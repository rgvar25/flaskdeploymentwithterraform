

resource "aws_security_group" "ec2_sg" {

	name = "ec2_sg" 
	vpc_id = var.vpc_id

	
	ingress{
		from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	ingress{
		from_port = 80
		to_port = 80 
		protocol = "tcp"
		security_groups = [var.lb_sg_id]
		
	}

	egress{
		from_port = 0
		to_port = 0
		protocol = "-1" 
		cidr_blocks = ["0.0.0.0/0"]

	}
}



resource "aws_instance" "ec2"{
	
	count = var.ec2_count
	ami = "ami-0522ab6e1ddcc7055"
	instance_type = "t2.micro"
	key_name  = "demo"
	subnet_id = var.subnet_id
	vpc_security_group_ids = [aws_security_group.ec2_sg.id]


	provisioner "remote-exec" {
		inline = [
			"sudo apt-get update",
			"sudo apt-get install -y python3-pip",
			"cd home/ubuntu",
			"git clone https://github.com/rgvar25/flaskHousingpricepredictor.git --branch main --single-branch",
			"cd flaskHousingpricepredictor"
		]

	connection {
		type = "ssh" 
		user = "ubuntu"
		private_key = file("/home/ronit/demo.pem")
		host = self.public_ip
	}

}

}
