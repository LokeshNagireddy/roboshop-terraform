terraform {
  backend "s3" {
    bucket = "terraform-practice-robo1"
    key    = "roboshop-terraform/dev/terraform.tfstate"
    region ="us-east-1"
  }
}