data "openstack_networking_network_v2" "impress" {
  name = var.external_pool
}