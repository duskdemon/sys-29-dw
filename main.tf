resource "yandex_compute_instance" "sys-29-dw-basthost" {
  name        = "sys-29-dw-basthost"
  hostname    = "sys-29-dw-basthost"
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
    user-data = "${file("./meta_bh.yml")}"
  }
 
  scheduling_policy {
    preemptible = "true"
  }
}
resource "yandex_compute_instance" "sys-29-dw-zabbix" {
  name        = "sys-29-dw-zabbix"
  hostname    = "sys-29-dw-zabbix"
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
  hostname    = "sys-29-dw-kibana"
  platform_id = "standard-v1"
  zone           = "ru-central1-b"

  resources {
    cores  = 2
    memory = 4
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
resource "yandex_compute_instance" "sys-29-dw-elas" {
  name        = "sys-29-dw-elas"
  hostname    = "sys-29-dw-elas"
  platform_id = "standard-v1"
  zone           = "ru-central1-a"

  resources {
    cores  = 2
    memory = 8
  }

  boot_disk {
    initialize_params {
      image_id = "fd8hrffch8s5lqq8haf8"
      size = 12
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
resource "yandex_compute_instance" "sys-29-dw-web1" {
  name        = "sys-29-dw-web1"
  hostname    = "sys-29-dw-web1"
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
  hostname    = "sys-29-dw-web2"
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