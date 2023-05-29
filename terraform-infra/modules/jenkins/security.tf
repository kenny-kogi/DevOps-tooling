
resource "aws_security_group" "jenkins-sg" {
  name = "${var.tags.env_prefix}-jenkins"
  vpc_id = var.vpc_id
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 9090
    protocol = "tcp"
    to_port = 9090
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 5432
    protocol = "tcp"
    to_port = 5432
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 8080
    protocol = "tcp"
    to_port = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 8443
    protocol = "tcp"
    to_port = 8443
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    protocol = "tcp"
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    protocol = "all"
    to_port = 0
    cidr_blocks = [
      "0.0.0.0/0"]
    ipv6_cidr_blocks = [
      "::0/0"]
  }
   tags = merge(
    var.tags,
    {
      "Name" = "${var.tags.env_prefix}-jenkins"
    }
  )
}
