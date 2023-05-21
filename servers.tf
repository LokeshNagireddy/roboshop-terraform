module "app-servers" {
  for_each = var.app_servers

  source = "./module"

  server_name=each.value["name"]
  env = var.env
  instance_type = each.value["instance_type"]
}