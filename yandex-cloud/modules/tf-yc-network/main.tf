data "yandex_vpc_network" "default" {
  name = "default"
}

resource "yandex_vpc_subnet" "default" {
  for_each = toset(var.network_zones)
  name     = "${data.yandex_vpc_network.default.name}-${each.value}"
  zone     = each.value
  network_id = data.yandex_vpc_network.default.id
  v4_cidr_blocks = ["10.0.${each.key}.0/24"]
}