data "aws_security_group" "allow-all" {
  name = "allow-all"
}

resource "aws_instance" "instance" {
  for_each = var.resources
  ami = "ami-0b5a2b5b8f2be4ec2"
  instance_type = each.value["instance_type"]
  vpc_security_group_ids = [data.aws_security_group.allow-all.id]

  tags = { Name = each.value["name"] }

  connection {
    type     = "ssh"
    user     = "centos"
    password = "DevOps321"
    host     = self.private_ip
  }

  provisioner "remote-exec" {
    inline = [
      "rm -rf roboshop-shell",
      "git clone https://github.com/LokeshNagireddy/roboshop-shell.git",
      "cd roboshop-shell",
      "sudo bash ${each.value["name"]}.sh"
    ]
  }
}

resource "aws_route53_record" "records" {
  for_each=var.resources
  name    = "${each.value["name"]}-dev.lokeshnagireddy.online"
  type    = "A"
  zone_id = "Z0994027IXESJVMWO1F5"
  ttl = 10
  records=[aws_instance.instance[each.value["name"]].private_ip]
}