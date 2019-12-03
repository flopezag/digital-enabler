variable "openstack_user_name" {}

variable "openstack_tenant_name" {}

variable "openstack_password" {}

variable "openstack_auth_url" {}

variable "openstack_region" {}

variable "openstack_domain_name" {}

variable "image" {
  default = "base_ubuntu_18.04"
}

variable "flavor" {
  default = "m1.large"
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

variable "network" {
	default  = "node-int-net-01"
}

