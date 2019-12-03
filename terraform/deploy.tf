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

resource "openstack_compute_keypair_v2" "tf_keypair" {
  region = var.openstack_region
  name = "tf_keypair"
}

#
# Create an Openstack Floating IP for the Main vm
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
  flavor_name = var.flavor
  key_pair = openstack_compute_keypair_v2.tf_keypair.name
  security_groups = [openstack_compute_secgroup_v2.tf_sec_group.name]
  network {
    name = var.network
  }
}

resource "openstack_compute_instance_v2" "Main" {
  name = "main"
  image_name = var.image
  availability_zone = var.availability_zone
  flavor_name = var.flavor
  key_pair = openstack_compute_keypair_v2.tf_keypair.name
  security_groups = [openstack_compute_secgroup_v2.tf_sec_group.name]
  network {
    name = var.network
  }
}

/*
resource "openstack_compute_instance_v2" "VM-2" {
  name = "vm-2"
  image_name = var.image
  availability_zone = var.availability_zone
  flavor_name = var.flavor
  key_pair = openstack_compute_keypair_v2.tf_keypair.name
  security_groups = [openstack_compute_secgroup_v2.tf_sec_group.name]
  network {
    name = var.network
  }
}

resource "openstack_compute_instance_v2" "VM-1" {
  name = "vm-1"
  image_name = var.image
  availability_zone = var.availability_zone
  flavor_name = var.flavor
  key_pair = openstack_compute_keypair_v2.tf_keypair.name
  security_groups = [openstack_compute_secgroup_v2.tf_sec_group.name]
  network {
    name = var.network
  }
}

resource "openstack_compute_instance_v2" "VM-1-2" {
  name = "vm-1-2"
  image_name = var.image
  availability_zone = var.availability_zone
  flavor_name = var.flavor
  key_pair = openstack_compute_keypair_v2.tf_keypair.name
  security_groups = [openstack_compute_secgroup_v2.tf_sec_group.name]
  network {
    name = var.network
  }
}


resource "openstack_compute_instance_v2" "VM-3" {
  name = "vm-3"
  image_name = var.image
  availability_zone = var.availability_zone
  flavor_name = var.flavor
  key_pair = openstack_compute_keypair_v2.tf_keypair.name
  security_groups = [openstack_compute_secgroup_v2.tf_sec_group.name]
  network {
    name = var.network
  }
}
*/
#
# Associate public IPs to the VMs
#
resource "openstack_compute_floatingip_associate_v2" "fip_main" {
  floating_ip = openstack_compute_floatingip_v2.fip_main.address
  instance_id = openstack_compute_instance_v2.Main.id
}
