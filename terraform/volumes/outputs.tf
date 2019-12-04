#
# show the Public and Private IP addresses of the virtual machines
#
output "Beaver_Volume"	{
	value = openstack_blockstorage_volume_v2.Beaver_Volume.id
}

output "Main_Volume"	{
	value = openstack_blockstorage_volume_v2.Main_Volume.id
}
