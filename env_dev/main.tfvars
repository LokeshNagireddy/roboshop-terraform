database_servers = {

  mongodb = {
    name          = "mongodb"
    instance_type = "t3.micro"
  }
  mysql = {
    name          = "mysql"
    instance_type = "t3.micro"
    password      = "RoboShop@1"
  }
}

app_servers = {

  frontend = {
    name          = "frontend"
    instance_type = "t3.micro"
  }

  catalogue = {
    name          = "catalogue"
    instance_type = "t3.micro"
  }

  user = {
    name          = "catalogue"
    instance_type = "t3.micro"
  }

  cart = {
    name          = "catalogue"
    instance_type = "t3.micro"
  }

  shipping = {
    name          = "catalogue"
    instance_type = "t3.micro"
  }
}

env = "dev"