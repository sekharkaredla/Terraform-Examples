provider "aws"{}

resource "aws_key_pair" "deployer"{
	key_name = "deployer-key"
	public_key = "${var.my_public_key}"
}



resource "aws_instance" "web" {
  ami = "${var.aws_ami_ubuntu}"
  instance_type = "${var.aws_instance_type}"
  key_name = "deployer-key"
  


 provisioner "local-exec" {
  command = "echo ${self.private_ip} > file.txt"
  		}

  provisioner "file"{
  	source = "changeMOTD.sh"
  	destination = "runScriptMOTD.sh"

	connection {
  		type = "ssh"
  		user = "ubuntu"
  		private_key = "${file("/Users/roshni/.ssh/id_rsa")}"
  		}  	

  }

  provisioner "remote-exec" {
  		inline = [
  		"chmod +x runScriptMOTD.sh",
  		"sudo -s 'truncate -s 0 /etc/motd'",
  		"sudo -s 'echo \"******** MOTD MESSAGE FROM SEKHAR ********\" > /etc/motd'"
  		]


  		connection {
  		type = "ssh"
  		user = "ubuntu"
  		private_key = "${file("/Users/roshni/.ssh/id_rsa")}"
  		}

  		}

  }