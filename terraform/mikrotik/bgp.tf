resource "routeros_routing_bgp_connection" "peer-to-talos" {
  name = "peer-to-talos"
  as   = "65000"
  remote {
    address = "192.168.253.1/24"
    as      = "65001"
    port    = "179"
  }
  local {
    role = "ebgp"
    port = "179"
  }
  connect = false
}