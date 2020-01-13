resource "openstack_blockstorage_volume_v2" "Beaver_Volume" {
  region      = var.openstack_region
  name        = "beaver_volume"
  description = "Volume corresponding to the Beaver instance in the Digital Enabler"
  size        = 70
}

resource "openstack_blockstorage_volume_v2" "Main_Volume" {
  region      = var.openstack_region
  name        = "main_volume"
  description = "Volume corresponding to the Main instance in the Digital Enabler"
  size        = 70
}

resource "openstack_blockstorage_volume_v2" "VM_2_Volume" {
  region      = var.openstack_region
  name        = "vm_2_volume"
  description = "Volume corresponding to the VM-2 instance in the Digital Enabler"
  size        = 70
}

resource "openstack_blockstorage_volume_v2" "VM_1_Volume" {
  region      = var.openstack_region
  name        = "vm_1_volume"
  description = "Volume corresponding to the VM-1 instance in the Digital Enabler"
  size        = 70
}

resource "openstack_blockstorage_volume_v2" "VM_1_2_Volume" {
  region      = var.openstack_region
  name        = "vm_1_2_volume"
  description = "Volume corresponding to the VM-1-2 instance in the Digital Enabler"
  size        = 70
}

resource "openstack_blockstorage_volume_v2" "VM_3_Volume" {
  region      = var.openstack_region
  name        = "vm_3_volume"
  description = "Volume corresponding to the VM-3 instance in the Digital Enabler"
  size        = 70
}

resource "openstack_blockstorage_volume_v2" "VM_4_Volume" {
  region      = var.openstack_region
  name        = "vm_4_volume"
  description = "Volume corresponding to the VM-4 instance in the Digital Enabler"
  size        = 70
}

resource "openstack_blockstorage_volume_v2" "VM_5_Volume" {
  region      = var.openstack_region
  name        = "vm_5_volume"
  description = "Volume corresponding to the VM-5 instance in the Digital Enabler"
  size        = 70
}

resource "openstack_blockstorage_volume_v2" "VM_6_Volume" {
  region      = var.openstack_region
  name        = "vm_6_volume"
  description = "Volume corresponding to the VM-6 instance in the Digital Enabler"
  size        = 70
}

resource "openstack_blockstorage_volume_v2" "VM_7_Volume" {
  region      = var.openstack_region
  name        = "vm_7_volume"
  description = "Volume corresponding to the VM-7 instance in the Digital Enabler"
  size        = 70
}

resource "openstack_blockstorage_volume_v2" "VM_7_2_Volume" {
  region      = var.openstack_region
  name        = "vm_7_2_volume"
  description = "Volume corresponding to the VM-7-2 instance in the Digital Enabler"
  size        = 70
}
