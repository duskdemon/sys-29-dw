resource "yandex_vpc_network" "sys-29-dw-vpc" {
  name = "sys-29-dw-vpc"
}

resource "yandex_vpc_subnet" "sys-29-dw-subnet-1" {
  name           = "sys-29-dw-subnet-1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.sys-29-dw-vpc.id
  v4_cidr_blocks = ["10.29.1.0/24"]
}
resource "yandex_vpc_subnet" "sys-29-dw-subnet-2" {
  name           = "sys-29-dw-subnet-2"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.sys-29-dw-vpc.id
  route_table_id = yandex_vpc_route_table.rt.id
  v4_cidr_blocks = ["10.29.2.0/24"]
}
resource "yandex_vpc_gateway" "nat_gateway" {
  folder_id      = "b1gsbai0ti98eg8eife1"
  name = "sys-29-dw-nat-gw"
  shared_egress_gateway {}
}
resource "yandex_vpc_route_table" "rt" {
  folder_id      = "b1gsbai0ti98eg8eife1"
  name       = "route-table"
  network_id = yandex_vpc_network.sys-29-dw-vpc.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}
resource "yandex_vpc_subnet" "sys-29-dw-subnet-3" {
  name           = "sys-29-dw-subnet-3"
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.sys-29-dw-vpc.id
  v4_cidr_blocks = ["10.29.3.0/24"]
}
#
#
#
resource "yandex_compute_instance" "sys-29-dw-basthost" {
  name        = "sys-29-dw-basthost"
  platform_id = "standard-v1"
  zone           = "ru-central1-b"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8hrffch8s5lqq8haf8"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.sys-29-dw-subnet-2.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
  }

  scheduling_policy {
    preemptible = "true"
  }
}
resource "yandex_compute_instance" "sys-29-dw-zabbix" {
  name        = "sys-29-dw-zabbix"
  platform_id = "standard-v1"
  zone           = "ru-central1-b"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8hrffch8s5lqq8haf8"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.sys-29-dw-subnet-2.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta_ext.yml")}"
  }

  scheduling_policy {
    preemptible = "true"
  }
}
resource "yandex_compute_instance" "sys-29-dw-kibana" {
  name        = "sys-29-dw-kibana"
  platform_id = "standard-v1"
  zone           = "ru-central1-b"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8hrffch8s5lqq8haf8"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.sys-29-dw-subnet-2.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta_ext.yml")}"
  }

  scheduling_policy {
    preemptible = "true"
  }
}
resource "yandex_compute_instance" "sys-29-dw-web1" {
  name        = "sys-29-dw-web1"
  platform_id = "standard-v1"
  zone           = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8hrffch8s5lqq8haf8"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.sys-29-dw-subnet-1.id
  }

  metadata = {
    user-data = "${file("./meta_user.yml")}"
  }

  scheduling_policy {
    preemptible = "true"
  }
}
resource "yandex_compute_instance" "sys-29-dw-web2" {
  name        = "sys-29-dw-web2"
  platform_id = "standard-v2"
  zone           = "ru-central1-d"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8hrffch8s5lqq8haf8"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.sys-29-dw-subnet-3.id
  }

  metadata = {
    user-data = "${file("./meta_user.yml")}"
  }

  scheduling_policy {
    preemptible = "true"
  }
}
resource "yandex_compute_instance" "sys-29-dw-elas" {
  name        = "sys-29-dw-elas"
  platform_id = "standard-v1"
  zone           = "ru-central1-a"

  resources {
    cores  = 2
    memory = 6
  }

  boot_disk {
    initialize_params {
      image_id = "fd8hrffch8s5lqq8haf8"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.sys-29-dw-subnet-1.id
  }

  metadata = {
    user-data = "${file("./meta_user.yml")}"
  }

  scheduling_policy {
    preemptible = "true"
  }
}