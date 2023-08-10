resource "aws_instance" "instance" {
  ami                    = data.aws_ami.centos.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [data.aws_security_group.allow-all.id]
  #  iam_instance_profile = aws_iam_instance_profile.instance_profile.name

  tags = { Name = local.name }
}

resource "null_resource" "provisioner" {
  count = var.provisioner ? 1 : 0
  depends_on = [aws_instance.instance, aws_route53_record.records]
  provisioner "remote-exec" {

    connection {
      type     = "ssh"
      user     = "centos"
      password = "DevOps321"
      host     = aws_instance.instance.private_ip
    }

    inline = [
      "rm -rf roboshop-shell",
      "git clone https://github.com/LokeshNagireddy/roboshop-shell.git",
      "cd roboshop-shell",
      "sudo bash ${var.server_name}.sh ${var.password}"
    ]
  }
}

resource "aws_route53_record" "records" {
  zone_id = "Z07729831S3V4CS8689QZ"
  name    = "${var.server_name}-dev.lokeshnagireddy.online"
  type    = "A"
  ttl = 10
  records=[aws_instance.instance.private_ip]
}