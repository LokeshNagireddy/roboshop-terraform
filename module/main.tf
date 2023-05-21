resource "aws_instance" "instance" {
  ami                    = data.aws_ami.centos.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [data.aws_security_group.allow-all.id]
  #  iam_instance_profile = aws_iam_instance_profile.instance_profile.name

  tags = { Name = var.server_name }
}

resource "null_resource" "provisioner" {
  count = var.provisioner ? 1 : 0
  depends_on = [aws_instance.instance, aws_route53_record.records]
  connection {
    type     = "ssh"
    user     = "centos"
    password = "DevOps321"
    host     = aws_instance.instance.private_ip
  }

  provisioner "remote-exec" {
    inline = [
      "rm -rf roboshop-shell",
      "git clone https://github.com/LokeshNagireddy/roboshop-shell.git",
      "cd roboshop-shell",
      "sudo bash ${var.server_name}.sh"
    ]
  }
}

resource "aws_route53_record" "records" {
  name    = "${var.server_name}-dev.lokeshnagireddy.online"
  type    = "A"
  zone_id = "Z0994027IXESJVMWO1F5"
  ttl = 10
  records=[aws_instance.instance.private_ip]
}