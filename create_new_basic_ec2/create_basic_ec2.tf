provider "aws" {}

resource "aws_instance" "web" {
  ami = "ami-0bbe6b35405ecebdb"
  instance_type = "t2.micro"
  }