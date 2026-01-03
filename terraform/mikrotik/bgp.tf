resource "routeros_routing_bgp_connection" "main" {
  name = local.bgp_name
  as   = local.bgp_as_number
  remote {
    address = local.bgp_remote_address
    as      = local.bgp_remote_as_number
    port    = "179"
  }
  local {
    role = "ebgp"
    port = "179"
  }
  # disable initiate the connection
  connect = false
}
