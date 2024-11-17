output "vpc_network" {
  value = data.yandex_vpc_network.default
}

output "vpc_subnet" {
  value = data.yandex_vpc_subnet.default
}