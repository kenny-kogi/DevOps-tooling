resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = merge(
  var.tags,
  {
    "Name" = "${var.tags.env_prefix}-vpc"
  }
  )
}

resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnet_cidrs)
  vpc_id = aws_vpc.main.id
  cidr_block = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)
  map_public_ip_on_launch = true
  tags = merge(
  var.tags,
  {
    Name = "${var.tags.env_prefix}-public-subnet-${count.index + 1}",
    "kubernetes.io/cluster/${var.tags.env_prefix}-eks-cluster" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }
  )
}

resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.main.id
  cidr_block = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)
  tags = merge(
  var.tags,
  {
    Name = "${var.tags.env_prefix}-private-subnet-${count.index + 1}"
    "kubernetes.io/cluster/${var.tags.env_prefix}-eks-cluster" = "shared",
    "kubernetes.io/role/internal-elb"           = "1"
  }
  )
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = merge(
  var.tags,
  {
    Name = "${var.tags.env_prefix}-${aws_vpc.main.id}-igw"
  }
  )
}

# Enable components in public subnet to access the Internet
resource "aws_route_table" "public_subnet_route_table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = merge(
  var.tags,
  {
    Name = "${var.tags.env_prefix}-public"
  }
  )
}

# Associate public subnets to the second table
resource "aws_route_table_association" "public_subnet_association" {
  count = length(var.public_subnet_cidrs)
  subnet_id = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.public_subnet_route_table.id
}

resource "aws_eip" "nat_gateway" {
  vpc = true
  tags = merge(
  var.tags,
  {
    "Name" = "${var.tags.env_prefix}-eip"
  }
  )
}

resource "aws_nat_gateway" "nat_gateway" {
  #allocation_id = aws_eip.nat_gateway[0].id
  allocation_id = aws_eip.nat_gateway.id
  subnet_id = aws_subnet.public_subnets[0].id
  tags = merge(
  var.tags,
  {
    "Name" = "${var.tags.env_prefix}-nat-gw"
  }
  )
}

resource "aws_route_table" "nat_gateway" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags = merge(
  var.tags,
  {
    "Name" = "${var.tags.env_prefix}-private"
  }
  )
}

resource "aws_route_table_association" "nat_gateway" {
  count = length(aws_subnet.private_subnets[*].id)
  subnet_id = element(aws_subnet.private_subnets[*].id, count.index)
  route_table_id = aws_route_table.nat_gateway.id
}

