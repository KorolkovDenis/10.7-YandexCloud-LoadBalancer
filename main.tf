terraform {
 required_providers {
   yandex = {
    source = "yandex-cloud/yandex"
   }
 }
}

provider "yandex" {
 token     = "y0_AgAAAABdN8UkAATuwQAAAADdj4vjMzJ1lYrVQY61TIuWIn-urJVr-RA"
 cloud_id  = "b1gbrtpi0pifkp8plfse"
 folder_id = "b1gg7rrhd2aekfb8okuo"
 zone      = "ru-central1-b"
}

resource "yandex_compute_instance" "vm" {
  count = 2

  name        = "vm${count.index}"
  platform_id = "standard-v3"
  resources {
    cores  = 2
    memory = 2
  }

boot_disk {
  initialize_params {
     image_id = "fd8s56jeuvv3pe3niji7"
    size = 3
  }
}

network_interface {
  subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
  nat       = true
}

metadata = {
  user-data = file("./meta.yml)
  }

}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-b"
  v4_cidr_blocks = ["192.168.10.0/24"]
  network_id     = "${yandex_vpc_network.network-1.id}"
  }

resource "yandex_lb_target_group" "target-1" {
  name      = "target1"
  target {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    address   = "${yandex_compute_instance.vm[0].network_interface.0.ip_address}"
  }
  target {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    address   = "${yandex_compute_instance.vm[1].network_interface.0.ip_address}"
  }
}

#задаём network_load_balancer

resource "yandex_lb_network_load_balancer" "lb-1" {
  name = "lb1"
  listener {
    name = "my-list"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }
  attached_target_group {
    target_group_id = yandex_lb_target_group.target-1.id
    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}

#полное копирование диска на первой виртуальной машине

resource "yandex_compute_snapshot" "snapshot-1" {
  name           = "snap1"
  source_disk_id = yandex_compute_instance.vm[0].boot_disk[0].disk_id
}

output "internal-vm-1" {
value = "${yandex_compute_instance.vm[0].network_interface.0.ip_address}"
}
output "internal-vm-2" {
value = "${yandex_compute_instance.vm[1].network_interface.0.ip_address}"
}
