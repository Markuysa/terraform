module "tf-yc-network" {
  source = "./modules/tf-yc-network"
  network_zones = var.network_zones
}

module "tf-yc-instance" {
  source = "./modules/tf-yc-instance"
  name = var.name
  cores = var.cores
  memory = var.memory
  image_id = var.image_id
  subnet_id = module.tf-yc-network.vpc_subnet
  ssh_key_path = var.ssh_key_path
  platform_id = var.platform_id
  zone = var.zone
}
