output "Public_DNS"{
	value = "${aws_instance.web_rhel.*.public_dns}"
}

output "Public_IP"{
	value = "${aws_instance.web_rhel.*.public_ip}"
}

output "VPC_Group_ID"{
	value = "${aws_instance.web_rhel.*.vpc_security_group_ids}"
}

output "Network_ID"{
	value = "${aws_instance.web_rhel.*.network_interface_id}"
}