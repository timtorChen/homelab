provider "proxmox" {
  pm_user     = local.pm_user
  pm_password = local.pm_password
  pm_api_url  = local.pm_api_url
}

# Create proxmox vms
resource "proxmox_vm_qemu" "k3s_nodes" {
  for_each = local.k3s_nodes

  #- node config
  vmid = each.value.id
  name = each.key

  ## sequentially assign from nuc11-01 to nuc11-03
  target_node = "nuc11-0${1 + index(keys(local.k3s_nodes), each.key) % 3}"
  cores       = each.value.cores
  memory      = each.value.memory
  clone       = each.value.template
  full_clone  = true

  disk {
    type    = "scsi"
    storage = each.value.storage
    size    = each.value.size
    discard = "on"
    ssd     = 1
  }

  #- cloud-init config
  ciuser     = each.value.user
  cipassword = each.value.password
  ipconfig0  = each.value.ipconfig0
  sshkeys    = each.value.sshkeys

  #- additionals
  ssh_forward_ip = each.value.ssh_forward_ip
}

# Generate the ansible inventory vm.hosts.ini
resource "local_file" "vm_inventory" {
  filename = "../ansible/inventory/vm.hosts.ini"
  content = templatefile("templates/vm.hosts.ini.tmpl", {
    k3s_server_nodes = { for name, node in local.k3s_nodes : name => node if node.server }
    k3s_agent_nodes  = { for name, node in local.k3s_nodes : name => node if !node.server }
  })
}

# Call ansible 
resource "null_resource" "k3s_ansible" {

  triggers = { inventory_content = local_file.vm_inventory.content }

  depends_on = [
    proxmox_vm_qemu.k3s_nodes,
    local_file.vm_inventory
  ]

  provisioner "local-exec" {
    working_dir = "../ansible"
    command     = <<EOF
     ansible-playbook \
     -i ${join(" -i", fileset(path.module, "../ansible/inventory/*.hosts.ini"))} \
     playbook/install.yml
     EOF
  }
}
