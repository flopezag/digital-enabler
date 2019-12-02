#
# show the Public and Private IP addresses of the virtual machines
output "Beaver"	{
	value = "${openstack_compute_instance_v2.Beaver.access_ip_v4} initialized with success"
}

output "Main"	{
	value = "${openstack_compute_floatingip_v2.fip_main.address} initialized with success"
}
