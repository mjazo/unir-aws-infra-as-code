variable "resource_group_location" {
  type        = string
  default     = "West Europe"
  description = "Localización del grupo de recursos."
}

variable "username" {
  type        = string
  description = "El nombre de usuario de la cuenta local que se creará en la nueva máquina virtual."
  default     = "mjazo"
}