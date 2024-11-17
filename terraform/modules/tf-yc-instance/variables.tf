variable "name" {
  description = "Name of the instance"
  type        = string
  default = "chapter5-lesson2-std-034-18"
}
variable "platform_id" {
  description = "Yandex.Cloud platform id"
  type        = string
  default     = "standard-v2"
}
variable "zone" {
  description = "Yandex.Cloud availability zone"
  type        = string
  default = "ru-central1-a"
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
variable "image_id" {
  description = "ID of the image to boot from"
  type        = string
  default = "fd80qm01ah03dkqb14lc"
}
variable "subnet_id" {
  description = "ID of the subnet to attach the instance to"
  type        = string
  default = "e7m1v3kq1vqg1q6q6v6g"
}
variable "ssh_key_path" {
  description = "Path to the SSH public key"
  type        = string
  default = "~/.ssh/id_rsa.pub"
}
variable "scheduling_policy" {
    description = "Scheduling policy for the instance"
    type        = string
    default = "on_demand"
}
