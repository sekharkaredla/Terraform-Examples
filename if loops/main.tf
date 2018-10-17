provider "aws"{}

/* key already exists
resource "aws_key_pair" "deployer"{
	key_name = "deployer-key"
	public_key = "${var.my_public_key}"
}*/


variable "create_rhel_instance" {
  description = "create rhel instance"
  default = "true"
}

variable "create_ubuntu_instance" {
  description = "create rhel instance"
  default = "false"
}


  resource "aws_instance" "web_rhel" {
  count = "${var.create_rhel_instance == true ? 2:0}"
  ami = "${var.aws_ami_rhel}"
  instance_type = "${var.aws_instance_type}"
  key_name = "deployer-key"

  tags {
    Name = "web_rhel - ${count.index}"
  }
  }

  resource "aws_instance" "web_ubuntu" {
  count = "${var.create_ubuntu_instance == true ? 2:0}"
  ami = "${var.aws_ami_ubuntu}"
  instance_type = "${var.aws_instance_type}"
  key_name = "deployer-key"

  tags {
    Name = "web_ubuntu - ${count.index}"
  }
  }
