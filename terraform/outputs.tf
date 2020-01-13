#
# show the Public and Private IP addresses of the virtual machines
#
output "Beaver"	{
	value = "${openstack_compute_instance_v2.Beaver.access_ip_v4} initialized with success"
}

output "Main"	{
	value = "${openstack_compute_floatingip_v2.fip_main.address} initialized with success"
}

output "VM-2"	{
	value = "${openstack_compute_instance_v2.VM-2.access_ip_v4} initialized with success"
}

output "VM-1"	{
	value = "${openstack_compute_instance_v2.VM-1.access_ip_v4} initialized with success"
}

output "VM-1-2"	{
	value = "${openstack_compute_instance_v2.VM-1-2.access_ip_v4} initialized with success"
}

output "VM-3"	{
	value = "${openstack_compute_instance_v2.VM-3.access_ip_v4} initialized with success"
}

output "VM-4"	{
	value = "${openstack_compute_instance_v2.VM-4.access_ip_v4} initialized with success"
}

output "VM-5"	{
	value = "${openstack_compute_instance_v2.VM-5.access_ip_v4} initialized with success"
}

output "VM-6"	{
	value = "${openstack_compute_instance_v2.VM-6.access_ip_v4} initialized with success"
}

output "VM-7"	{
	value = "${openstack_compute_instance_v2.VM-7.access_ip_v4} initialized with success"
}

output "VM-7-2"	{
	value = "${openstack_compute_instance_v2.VM-7-2.access_ip_v4} initialized with success"
}

output "Keypair" {
	value = openstack_compute_keypair_v2.tf_keypair.private_key
}
