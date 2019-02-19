resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpc_cidr_block}"

  tags       = {
    Name = "${var.network_name}"
  }
}

resource "aws_subnet" "public" {
  count             = "${length(var.public_subnet_azs)}"
  vpc_id            = "${aws_vpc.vpc.id}"
  availability_zone = "${element(var.public_subnet_azs, count.index)}"
  cidr_block        = "${element(var.public_subnet_cidr_blocks, count.index)}"

  tags              = {
    Name = "${var.network_name} public (${count.index})"
  }
}

resource "aws_subnet" "private" {
  count             = "${length(var.private_subnet_azs)}"
  vpc_id            = "${aws_vpc.vpc.id}"
  availability_zone = "${element(var.private_subnet_azs, count.index)}"
  cidr_block        = "${element(var.private_subnet_cidr_blocks, count.index)}"

  tags              = {
    Name = "${var.network_name} private (${count.index})"
  }
}

resource "aws_route_table" "public_subnet" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags   = {
    Name = "${var.network_name} public"
  }
}

resource "aws_route_table_association" "public" {
  count          = "${length(var.public_subnet_azs)}"
  route_table_id = "${aws_route_table.public_subnet.id}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
}


resource "aws_route_table" "private_subnet" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat.id}"
  }

  tags   = {
    Name = "${var.network_name} private"
  }
}

resource "aws_route_table_association" "private_subnet" {
  count          = "${length(var.private_subnet_azs)}"
  route_table_id = "${aws_route_table.private_subnet.id}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags   = {
    Name = "${var.network_name}"
  }
}

resource "aws_eip" "nat" {
  vpc      = true

  tags       = {
    Name = "${var.network_name} NAT"
  }
}

# TODO Put a NAT Gateway into each public subnet
resource "aws_nat_gateway" "nat" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.public.0.id}"

  depends_on    = [
    "aws_internet_gateway.igw"]

  tags          = {
    Name = "${var.network_name} NAT"
  }
}

