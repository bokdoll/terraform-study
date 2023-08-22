variable "string" {
  type        = string
  description = "var String"
  default     = "myString"
}

variable "number" {
  type    = number
  default = 123
}

variable "boolean" {
  default = true
}

variable "list" {
  default = [
    "google",
    "vmware",
    "amazon",
    "microsoft"
  ]
}

output "list_index_0" {
  value = var.list.0
}

output "list_all" {
  value = [
    for name in var.list :
    upper(name)
  ]
}

variable "map" { # Sorting
  default = {
    aws   = "amazon",
    azure = "microsoft",
    gcp   = "google"
  }
}

variable "set" { # Sorting
  type = set(string)
  default = [
    "google",
    "vmware",
    "amazon",
    "microsoft"
  ]
}

variable "object" {
  type = object({
    name = string,
    age  = number
  })
  default = {
    name = "abc",
    age  = 12
  }
}

variable "tuple" {
  type    = tuple([string, number, bool])
  default = ["abc", 123, true]
}

variable "ingress_rules" {
  type = list(object({
    port        = number,
    description = optional(string),
    protocol    = optional(string, "tcp")
    }
  ))
  default = [
    { port = 80, description = "web" },
    { port = 53, protocol = "udp" }
  ]
}

variable "image_id" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."

  validation {
    condition     = length(var.image_id) > 4
    error_message = "The image_id value must exceed 4."
  }

  validation {
    # regrex(...) failes if it cannot find a match
    condition     = can(regex("^ami-", var.image_id))
    error_message = "The image_id value must starting with \"ami-\"."
  }
}