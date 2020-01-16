#
# Create a security group
#
resource "openstack_compute_secgroup_v2" "tf_sec_group" {
    region = ""
    name = "tf_sec_group"
    description = "Security Group Via Terraform"
    rule {
        from_port = 22
        to_port = 22
        ip_protocol = "tcp"
        cidr = "0.0.0.0/0"
    }
}

#
# Create a keypair
#
resource "openstack_compute_keypair_v2" "tf_keypair" {
  region = var.openstack_region
  name = "tf_keypair"
}


#
# Create network interface
#
resource "openstack_networking_network_v2" "impress" {
  name = "impress"
  admin_state_up = "true"
  region = var.openstack_region
}

resource "openstack_networking_subnet_v2" "impress" {
  name = "impress"
  network_id = openstack_networking_network_v2.impress.id
  cidr = "10.0.0.0/24"
  ip_version = 4
  dns_nameservers = ["8.8.8.8","8.8.4.4"]
  region = var.openstack_region
}

resource "openstack_networking_router_v2" "impress" {
  name = "impress"
  admin_state_up = "true"
  region = var.openstack_region
  external_network_id = data.openstack_networking_network_v2.impress.id
}

resource "openstack_networking_router_interface_v2" "terraform" {
  router_id = openstack_networking_router_v2.impress.id
  subnet_id = openstack_networking_subnet_v2.impress.id
  region = var.openstack_region
}

#
# Create an Openstack Floating IP for the Main VM
#
resource "openstack_compute_floatingip_v2" "fip_main" {
    region = var.openstack_region
    pool = "public-ext-net-01"
}


#
# Create the VM Instances for Digital Enabler
#
resource "openstack_compute_instance_v2" "Beaver" {
  name = "beaver"
  image_name = var.image
  availability_zone = var.availability_zone
  flavor_name = var.openstack_flavor
  key_pair = openstack_compute_keypair_v2.tf_keypair.name
  security_groups = [openstack_compute_secgroup_v2.tf_sec_group.name]
  network {
    uuid = openstack_networking_network_v2.impress.id
  }
}

resource "openstack_compute_instance_v2" "Main" {
  name = "main"
  image_name = var.image
  availability_zone = var.availability_zone
  flavor_name = var.openstack_flavor
  key_pair = openstack_compute_keypair_v2.tf_keypair.name
  security_groups = [openstack_compute_secgroup_v2.tf_sec_group.name]
  network {
    uuid = openstack_networking_network_v2.impress.id
  }
}

resource "openstack_compute_instance_v2" "VM-2" {
  name = "vm-2"
  image_name = var.image
  availability_zone = var.availability_zone
  flavor_name = var.openstack_flavor
  key_pair = openstack_compute_keypair_v2.tf_keypair.name
  security_groups = [openstack_compute_secgroup_v2.tf_sec_group.name]
  network {
    uuid = openstack_networking_network_v2.impress.id
  }
}

resource "openstack_compute_instance_v2" "VM-1" {
  name = "vm-1"
  image_name = var.image
  availability_zone = var.availability_zone
  flavor_name = var.openstack_flavor
  key_pair = openstack_compute_keypair_v2.tf_keypair.name
  security_groups = [openstack_compute_secgroup_v2.tf_sec_group.name]
  network {
    uuid = openstack_networking_network_v2.impress.id
  }
}

resource "openstack_compute_instance_v2" "VM-1-2" {
  name = "vm-1-2"
  image_name = var.image
  availability_zone = var.availability_zone
  flavor_name = var.openstack_flavor
  key_pair = openstack_compute_keypair_v2.tf_keypair.name
  security_groups = [openstack_compute_secgroup_v2.tf_sec_group.name]
  network {
    uuid = openstack_networking_network_v2.impress.id
  }
}

resource "openstack_compute_instance_v2" "VM-3" {
  name = "vm-3"
  image_name = var.image
  availability_zone = var.availability_zone
  flavor_name = var.openstack_flavor
  key_pair = openstack_compute_keypair_v2.tf_keypair.name
  security_groups = [openstack_compute_secgroup_v2.tf_sec_group.name]
  network {
    uuid = openstack_networking_network_v2.impress.id
  }
}

resource "openstack_compute_instance_v2" "VM-4" {
  name = "vm-4"
  image_name = var.image
  availability_zone = var.availability_zone
  flavor_name = var.openstack_flavor
  key_pair = openstack_compute_keypair_v2.tf_keypair.name
  security_groups = [openstack_compute_secgroup_v2.tf_sec_group.name]
  network {
    uuid = openstack_networking_network_v2.impress.id
  }
}

resource "openstack_compute_instance_v2" "VM-5" {
  name = "vm-5"
  image_name = var.image
  availability_zone = var.availability_zone
  flavor_name = var.openstack_flavor
  key_pair = openstack_compute_keypair_v2.tf_keypair.name
  security_groups = [openstack_compute_secgroup_v2.tf_sec_group.name]
  network {
    uuid = openstack_networking_network_v2.impress.id
  }
}

resource "openstack_compute_instance_v2" "VM-6" {
  name = "vm-6"
  image_name = var.image
  availability_zone = var.availability_zone
  flavor_name = var.openstack_flavor
  key_pair = openstack_compute_keypair_v2.tf_keypair.name
  security_groups = [openstack_compute_secgroup_v2.tf_sec_group.name]
  network {
    uuid = openstack_networking_network_v2.impress.id
  }
}

resource "openstack_compute_instance_v2" "VM-7" {
  name = "vm-7"
  image_name = var.image
  availability_zone = var.availability_zone
  flavor_name = var.openstack_flavor
  key_pair = openstack_compute_keypair_v2.tf_keypair.name
  security_groups = [openstack_compute_secgroup_v2.tf_sec_group.name]
  network {
    uuid = openstack_networking_network_v2.impress.id
  }
}

resource "openstack_compute_instance_v2" "VM-7-2" {
  name = "vm-7-2"
  image_name = var.image
  availability_zone = var.availability_zone
  flavor_name = var.openstack_flavor
  key_pair = openstack_compute_keypair_v2.tf_keypair.name
  security_groups = [openstack_compute_secgroup_v2.tf_sec_group.name]
  network {
    uuid = openstack_networking_network_v2.impress.id
  }
}

#
# Associate public IPs to the VMs
#
resource "openstack_compute_floatingip_associate_v2" "fip_main" {
  floating_ip = openstack_compute_floatingip_v2.fip_main.address
  instance_id = openstack_compute_instance_v2.Main.id
}

#
# Attaching volumes to the instances
#
resource "openstack_compute_volume_attach_v2" "va_beaver" {
  region = var.openstack_region
  instance_id = openstack_compute_instance_v2.Beaver.id
  volume_id   = var.openstack_beaver_volume_id
}

resource "openstack_compute_volume_attach_v2" "va_main" {
  region = var.openstack_region
  instance_id = openstack_compute_instance_v2.Main.id
  volume_id   = var.openstack_main_volume_id
}

resource "openstack_compute_volume_attach_v2" "va_vm_2" {
  region = var.openstack_region
  instance_id = openstack_compute_instance_v2.VM-2.id
  volume_id   = var.openstack_vm_2_volume_id
}

resource "openstack_compute_volume_attach_v2" "va_vm_1" {
  region = var.openstack_region
  instance_id = openstack_compute_instance_v2.VM-1.id
  volume_id   = var.openstack_vm_1_volume_id
}

resource "openstack_compute_volume_attach_v2" "va_vm_1_2" {
  region = var.openstack_region
  instance_id = openstack_compute_instance_v2.VM-1-2.id
  volume_id   = var.openstack_vm_1_2_volume_id
}

resource "openstack_compute_volume_attach_v2" "va_vm_3" {
  region = var.openstack_region
  instance_id = openstack_compute_instance_v2.VM-3.id
  volume_id   = var.openstack_vm_3_volume_id
}

resource "openstack_compute_volume_attach_v2" "va_vm_4" {
  region = var.openstack_region
  instance_id = openstack_compute_instance_v2.VM-4.id
  volume_id   = var.openstack_vm_4_volume_id
}

resource "openstack_compute_volume_attach_v2" "va_vm_5" {
  region = var.openstack_region
  instance_id = openstack_compute_instance_v2.VM-5.id
  volume_id   = var.openstack_vm_5_volume_id
}

resource "openstack_compute_volume_attach_v2" "va_vm_6" {
  region = var.openstack_region
  instance_id = openstack_compute_instance_v2.VM-6.id
  volume_id   = var.openstack_vm_6_volume_id
}

resource "openstack_compute_volume_attach_v2" "va_vm_7" {
  region = var.openstack_region
  instance_id = openstack_compute_instance_v2.VM-7.id
  volume_id   = var.openstack_vm_7_volume_id
}

resource "openstack_compute_volume_attach_v2" "va_vm_7_2" {
  region = var.openstack_region
  instance_id = openstack_compute_instance_v2.VM-7-2.id
  volume_id   = var.openstack_vm_7_2_volume_id
}
