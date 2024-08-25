


variable "vpc_cidr" {
	description="CIDR block for vpc"
	type = string
}


variable "subnet_count" {

	description="Number of subnets"
	type = number
}



variable "subnet_cidr" {
	description= "CIDR block for subnet"
	type = list(string)
}

variable "subnet_az" {
	description="AZ for subnet"
	type = list(string)
}




