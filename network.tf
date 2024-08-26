resource "yandex_vpc_network" "sys-29-dw-vpc" {
  name = "sys-29-dw-vpc"
}

resource "yandex_vpc_subnet" "sys-29-dw-subnet-1" {
  name           = "sys-29-dw-subnet-1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.sys-29-dw-vpc.id
  route_table_id = yandex_vpc_route_table.rt.id
  v4_cidr_blocks = ["10.29.1.0/24"]
}
resource "yandex_vpc_subnet" "sys-29-dw-subnet-2" {
  name           = "sys-29-dw-subnet-2"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.sys-29-dw-vpc.id
  route_table_id = yandex_vpc_route_table.rt.id
  v4_cidr_blocks = ["10.29.2.0/24"]
}
resource "yandex_vpc_subnet" "sys-29-dw-subnet-3" {
  name           = "sys-29-dw-subnet-3"
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.sys-29-dw-vpc.id
  route_table_id = yandex_vpc_route_table.rt.id
  v4_cidr_blocks = ["10.29.3.0/24"]
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
