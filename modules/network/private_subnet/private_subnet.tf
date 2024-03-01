#--------------------------------------------------------------
# Este modulo crea los recursos necesario para una subred privada
#--------------------------------------------------------------

variable "name"                     { default = "private"}
variable "tags"                     { }
variable "vpc_id"                   { }
variable "cidrs"                    { }
variable "azs"                      { }
variable "nat_gateway_ids"          { }



locals {
  create_nat = var.nat_gateway_ids != null ? true : false
}

resource "aws_subnet" "private" {
  vpc_id            = var.vpc_id
  cidr_block        = element(var.cidrs, count.index)
  availability_zone = element(var.azs, count.index)
  count             = length(var.cidrs)

  tags  = merge(
    var.tags,
    { Name = "${var.name}.${element(var.azs, count.index)}" },
  )
  
  lifecycle { create_before_destroy = true }
}

//NAT Gateway
resource "aws_route_table" "private" {  
  vpc_id = var.vpc_id
  count  = local.create_nat ?  length(var.cidrs) : 0

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(var.nat_gateway_ids, count.index)
  }

  tags  = merge(
    var.tags,
    { Name = "${var.name}.${element(var.azs, count.index)}" },
  )

  lifecycle { create_before_destroy = true }
}


resource "aws_route_table_association" "private" {
  count          = local.create_nat ? length(var.cidrs) : 0
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)

  lifecycle { create_before_destroy = true }
}

output "subnet_ids" { value = "${aws_subnet.private.*.id}" }
output "cidr_block" { value = "${aws_subnet.private.*.cidr_block}" }
output "route_ids" { value = "${aws_route_table.private.*.id}" }