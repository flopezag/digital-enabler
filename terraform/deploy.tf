# Source: https://github.com/terraform-providers/terraform-provider-openstack/blob/master/examples/app-with-networking/main.tf

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

# Remote execution
#
/*
provisioner "remote-exec" {
connection {
user = "${var.ssh_user_name}"
key_file = "${var.ssh_key_file}"
}

inline = [
"sudo apt-get -y update",
"sudo apt-get -y install nginx",
"sudo service nginx start"
]
}
}
*/