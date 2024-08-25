

variable "vpc_id" {
	type = string
}


variable "lb_name" {
	type = string
}

variable "public_subnets" {
	type = list(string) 
}



variable "instance_ids" {

	type = list(string)
}
