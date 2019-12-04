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

variable "external_pool" {
  default = "public-ext-net-01"
}

variable "main_volume_id" {}

variable "beaver_volume_id" {}
