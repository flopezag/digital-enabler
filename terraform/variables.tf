variable "openstack_user_name" {}

variable "openstack_tenant_name" {}

variable "openstack_password" {}

variable "openstack_auth_url" {}

variable "openstack_region" {}

variable "openstack_domain_name" {}

variable "openstack_flavor" {}

variable "openstack_main_volume_id" {}

variable "openstack_beaver_volume_id" {}

variable "openstack_vm_2_volume_id" {}

variable "openstack_vm_1_volume_id" {}

variable "openstack_vm_1_2_volume_id" {}

variable "openstack_vm_3_volume_id" {}

variable "openstack_vm_4_volume_id" {}

variable "openstack_vm_5_volume_id" {}

variable "openstack_vm_6_volume_id" {}

variable "openstack_vm_7_volume_id" {}

variable "openstack_vm_7_2_volume_id" {}

variable "image" {
  default = "base_ubuntu_18.04"
}

variable "ssh_key_pair" {
  default = "fla"
}

variable "ssh_user_name" {
  default = "ubuntu"
}

variable "availability_zone" {
	default = "nova"
}

variable "external_pool" {
  default = "public-ext-net-01"
}
