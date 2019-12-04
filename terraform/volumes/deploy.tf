resource "openstack_blockstorage_volume_v2" "Beaver_Volume" {
  region      = "Spain2"
  name        = "beaver_volume"
  description = "Volume corresponding to the Beaver instance in the Digital Enabler"
  size        = 70
}

resource "openstack_blockstorage_volume_v2" "Main_Volume" {
  region      = "Spain2"
  name        = "main_volume"
  description = "Volume corresponding to the Main instance in the Digital Enabler"
  size        = 70
}
