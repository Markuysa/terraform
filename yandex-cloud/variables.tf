variable "token" {
  description = "Yandex.Cloud OAuth token"
  type        = string
}
variable "name" {
  description = "Name of the instance"
  type        = string
  default = "chapter5-lesson2-std-034-18"
}
variable "cores" {
  description = "Number of CPU cores"
  type        = number
  default = 2
}
variable "memory" {
  description = "Amount of memory in GB"
  type        = number
  default = 2
}
variable "ssh_key_path" {
  description = "Path to the SSH public key"
  type        = string
  default = "~/.ssh/id_rsa.pub"
}
variable "image_id" {
  description = "Yandex.Cloud image id"
  type  = string
  default = "fd80qm01ah03dkqb14lc"
}
variable "cloud_id" {
  description = "Yandex.Cloud ID"
  type        = string
  default = "b1g3jddf4nv5e9okle7p"
}
variable "folder_id" {
  description = "Yandex.Cloud folder ID"
  type        = string
  default = "b1g5o5q2pf440u9rsj07"
}
variable "zone" {
  description = "Yandex.Cloud availability zone"
  type        = string
  default = "ru-central1-a"
}
variable "network_zones" {
  description = "Yandex.Cloud network availability zones"
  type        = set(string)
  default     = ["ru-central1-a", "ru-central1-b", "ru-central1-c"]
}
variable "platform_id" {
  description = "Yandex.Cloud platform id"
  type        = string
  default     = "standard-v2"
}