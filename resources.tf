resource "yandex_alb_target_group" "sys-29-dw-tg" {
  name           = "sys-29-dw-tg"

  target {
    subnet_id    = "${yandex_vpc_subnet.sys-29-dw-subnet-1.id}"
    ip_address   = "${yandex_compute_instance.sys-29-dw-web1.network_interface.0.ip_address}"
  }

  target {
    subnet_id    = "${yandex_vpc_subnet.sys-29-dw-subnet-3.id}"
    ip_address   = "${yandex_compute_instance.sys-29-dw-web2.network_interface.0.ip_address}"
  }

}
resource "yandex_alb_backend_group" "sys-29-dw-bg" {
  name                     = "sys-29-dw-bg"
/*   session_affinity {
    connection {
      source_ip = "127.0.0.1"
    }
  } */

  http_backend {
    name                   = "sys-29-dw-backend"
    weight                 = 1
    port                   = 80
    target_group_ids       = ["${yandex_alb_target_group.sys-29-dw-tg.id}"]
    load_balancing_config {
      panic_threshold      = 90
    }    
    healthcheck {
      timeout              = "10s"
      interval             = "2s"
      healthy_threshold    = 10
      unhealthy_threshold  = 15 
      http_healthcheck {
        path               = "/"
      }
    }
  }
}
resource "yandex_alb_http_router" "sys-29-dw-rt" {
  name      = "sys-29-dw-rt"
/*   labels {
    tf-label    = "sys-29-dw-rt"
    empty-label = "s"
  } */
}
resource "yandex_alb_virtual_host" "sys-29-dw-vh" {
  name      = "sys-29-dw-vh"
  http_router_id = yandex_alb_http_router.sys-29-dw-rt.id
  route {
    name = "main"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.sys-29-dw-bg.id
        timeout = "3s"
      }
    }
  }
}
resource "yandex_alb_load_balancer" "sys-29-dw-alb" {
  name        = "sys-29-dw-alb"
  network_id  = "${yandex_vpc_network.sys-29-dw-vpc.id}"


  allocation_policy {
    location {
      zone_id   = "ru-central1-d"
      subnet_id = "${yandex_vpc_subnet.sys-29-dw-subnet-3.id}"
    }
  }

  listener {
    name = "sys-29-dw-lr"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [ 80 ]
    }
    http {
      handler {
        http_router_id = "${yandex_alb_http_router.sys-29-dw-rt.id}"
      }
    }
  }

/*   log_options {
    log_group_id = "<идентификатор_лог-группы>"
    discard_rule {
      http_codes          = ["<HTTP-код>"]
      http_code_intervals = ["<класс_HTTP-кодов>"]
      grpc_codes          = ["<gRPC-код>"]
      discard_percent     = <доля_отбрасываемых_логов>
    }
  } */
}