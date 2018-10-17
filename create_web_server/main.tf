provider "aws"{}

resource "aws_key_pair" "deployer"{
	key_name = "deployer-key"
	public_key = "${var.my_public_key}"
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "web_server" {
  ami = "${var.aws_ami_ubuntu}"
  instance_type = "${var.aws_instance_type}"
  key_name = "deployer-key"

  tags {
  Name = "web-server-ubuntu"
  }

  security_groups = ["allow_all"]

    provisioner "local-exec" {
    command = "echo ${aws_instance.web_server.public_ip} > public-ip.txt"
  }
  

  connection{
  user = "ubuntu"
  private_key = "${file("/Users/roshni/.ssh/id_rsa")}"
  }

  provisioner "remote-exec" {
    inline = [
    "echo y | sudo bash -c 'apt-get update'",
      "echo y | sudo bash -c 'apt-get install apache2 -y'",
      "sudo bash -c 'systemctl enable apache2'",
      "sudo bash -c 'systemctl start apache2'",
      "sudo bash -c 'chmod 777 /var/www/html/index.html'"
    ]
  }

  provisioner "file"{
  	source = "index.html"
  	destination = "/var/www/html/index.html"
  }



  }