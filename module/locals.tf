locals {
  name = var.env != "" ? "${var.server_name}-${var.env}" : var.server_name
}