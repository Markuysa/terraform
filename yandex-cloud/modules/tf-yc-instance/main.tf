resource "yandex_compute_instance" "vm-1" {
  name = var.name

  resources {
    cores  = var.cores
    memory = var.memory
    zone   = var.zone
    platform_id = var.platform_id
    scheduling_policy = var.scheduling_policy
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = false
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_key_path)}"
  }
}
