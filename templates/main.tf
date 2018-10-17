provider "aws"{}

resource "aws_key_pair" "deployer"{
  key_name = "deployer-key"
  public_key = "${var.my_public_key}"
}

data "template_file" "template_env_data"{
  template = "${file("${path.module}/user_data_${var.env}")}"
}

resource "aws_instance" "web" {
  ami = "${var.aws_ami_ubuntu}"
  instance_type = "${trimspace(data.template_file.template_env_data.rendered)}"
  key_name = "deployer-key"

  tags {
  	Name = "web - template"
  }
  }
