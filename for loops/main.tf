provider "aws"{}

resource "aws_key_pair" "deployer"{
	key_name = "deployer-key"
	public_key = "${var.my_public_key}"
}

resource "aws_instance" "web" {
  count = 3
  ami = "${var.aws_ami_ubuntu}"
  instance_type = "${var.aws_instance_type}"
  key_name = "deployer-key"

  tags {
  	Name = "web - ${count.index}"
  }

   provisioner "local-exec" {
  command = "echo ${self.private_ip} > file.txt"
  		}
  }
