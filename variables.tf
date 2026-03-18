variable "project_id" {
  description = "ID проєкту в Google Cloud"
  type        = string
}

variable "region" {
  description = "Регіон для розгортання"
  type        = string
  default     = "europe-west3"
}

variable "subnet_a_cidr" {
  description = "CIDR для Subnet A"
  type        = string
}

variable "subnet_b_cidr" {
  description = "CIDR для Subnet B"
  type        = string
}

variable "web_port" {
  description = "Порт для веб-сервера"
  type        = string
}