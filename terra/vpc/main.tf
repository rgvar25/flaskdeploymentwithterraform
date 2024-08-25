resource "aws_vpc" "flask_vpc" {

	cidr_block = var.vpc_cidr

	tags = {
		name = "flask_vpc"
	}
}
resource "aws_subnet" "public" {
	count = var.subnet_count
	vpc_id = aws_vpc.flask_vpc.id	
	cidr_block = element(var.subnet_cidr,count.index)
	availability_zone = element(var.subnet_az,count.index)
	map_public_ip_on_launch = true
	tags = {
		name = "flask_public_subnet"
	}
}	

resource "aws_internet_gateway" "ig" {
	vpc_id = aws_vpc.flask_vpc.id	
	tags = {
		name = "flask_internet_gateway"
	}
}
resource "aws_route_table" "rt" {
	vpc_id = aws_vpc.flask_vpc.id
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = aws_internet_gateway.ig.id
		}
	tags = {
		name = "flask_route_table"
	}
}

resource "aws_route_table_association" "rta" {
	
	count = var.subnet_count
	subnet_id = aws_subnet.public[count.index].id
	route_table_id = aws_route_table.rt.id
}
