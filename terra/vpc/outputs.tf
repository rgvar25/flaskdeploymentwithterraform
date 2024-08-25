


output "vpc_id"{
	value = aws_vpc.flask_vpc.id
}


output "public_subnet_id" {
	value = aws_subnet.public[*].id
}


output "rout_table_id" {

	value = aws_route_table.rt.id
}


output "ig_id" {

	value = aws_internet_gateway.ig.id

}


