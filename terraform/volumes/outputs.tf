#
# show the Public and Private IP addresses of the virtual machines
#
output "Beaver_Volume"	{
	value = openstack_blockstorage_volume_v2.Beaver_Volume.id
}

output "Main_Volume"	{
	value = openstack_blockstorage_volume_v2.Main_Volume.id
}

output "VM_2_Volume"	{
	value = openstack_blockstorage_volume_v2.VM_2_Volume.id
}

output "VM_1_Volume"	{
	value = openstack_blockstorage_volume_v2.VM_1_Volume.id
}

output "VM_1_2_Volume"	{
	value = openstack_blockstorage_volume_v2.VM_1_2_Volume.id
}

output "VM_3_Volume"	{
	value = openstack_blockstorage_volume_v2.VM_3_Volume.id
}

output "VM_4_Volume"	{
	value = openstack_blockstorage_volume_v2.VM_4_Volume.id
}

output "VM_5_Volume"	{
	value = openstack_blockstorage_volume_v2.VM_5_Volume.id
}

output "VM_6_Volume"	{
	value = openstack_blockstorage_volume_v2.VM_6_Volume.id
}

output "VM_7_Volume"	{
	value = openstack_blockstorage_volume_v2.VM_7_Volume.id
}

output "VM_7_2_Volume"	{
	value = openstack_blockstorage_volume_v2.VM_7_2_Volume.id
}
