


resource "aws_security_group" "alb_sg"{

	name = "alb_sg"
	vpc_id = var.vpc_id
	

	ingress {
		from_port = 80 
		to_port = 80 
		protocol = "tcp" 
		cidr_blocks = ["0.0.0.0/0"]
	}

	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	
	}
	

}


resource "aws_lb" "lb" {
	
	name = var.lb_name 
	internal = false
	load_balancer_type = "application"
	security_groups = [aws_security_group.alb_sg.id]
	subnets = var.public_subnets
	
}


resource "aws_lb_target_group" "lb_tg" {
	
	name = "${aws_lb.lb.name}-tg"
	vpc_id = var.vpc_id
	port = 80
	protocol = "HTTP"

}

resource "aws_lb_listener" "http_listener" {
	load_balancer_arn = aws_lb.lb.arn
	port = 80 
	protocol = "HTTP"

	default_action {
		type = "forward" 
		target_group_arn = aws_lb_target_group.lb_tg.arn
	}
}



resource "aws_lb_target_group_attachment" "tg_attachment" {
	count = length(var.instance_ids)
	target_group_arn  = aws_lb_target_group.lb_tg.arn
	target_id = element(var.instance_ids , count.index)
	port = 80 



}
