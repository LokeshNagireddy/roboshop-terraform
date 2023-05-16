/*
variable "instance-type" {
  default="t3.micro"
}
*/

data "aws_security_group" "allow-all" {
  name = "allow-all"
}

variable "resources" {
  default = {
    frontend = {
      name = "frontend"
      instance_type = "t3.micro"
    }
    mongodb ={
      name = "mongodb"
      instance_type = "t3.micro"
    }
  }
}
resource "aws_instance" "instance" {
  for_each = var.resources
  ami = "ami-0b5a2b5b8f2be4ec2"
  instance_type = each.value["instance_type"]
  vpc_security_group_ids = [data.aws_security_group.allow-all.id]

  tags = { Name = each.value["name"] }
}

resource "aws_route53_record" "records" {
  for_each=var.resources
  name    = "${each.value["name"]}-dev.lokeshnagireddy.online"
  type    = "A"
  zone_id = "Z0994027IXESJVMWO1F5"
  ttl = 10
  records=[aws_instance.instance[each.value["name"]].private_ip]
}