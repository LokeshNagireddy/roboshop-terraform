locals {
  name        = var.env != "" ? "${var.server_name}-${var.env}" : var.server_name
  db_commands = [
    "rm -rf roboshop-shell",
    "git clone https://github.com/LokeshNagireddy/roboshop-shell.git",
    "cd roboshop-shell",
    "sudo bash ${var.server_name}.sh ${var.password}"
  ]
  app_commands = [
    "sudo labauto ansible",
     "ansible-pull -i localhost, -U https://github.com/LokeshNagireddy/roboshop-ansible.git roboshop.yml -e env=${var.env} -e role_name=${var.server_name}"
  ]
}