variable "network_zones" {
  description = "Yandex.Cloud network availability zones"
  type        = set(string)
  default     = ["ru-central1-a", "ru-central1-b", "ru-central1-c"]
}