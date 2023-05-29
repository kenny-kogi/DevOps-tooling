data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_instance" "kubernetes" {
  ami = "ami-0f62e5a363d54d073"
  instance_type = var.kubernetes_props.bastion_instance_type
  subnet_id = var.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.kubernetes-sg.id]
  availability_zone = data.aws_availability_zones.available.names[0]
  key_name = var.kubernetes_props.aws_key_pair
  user_data = "${path.module}/eks-config/eks-setup.sh"
  
    tags = merge(
    var.tags,
    {
      "Name" = "${var.tags.env_prefix}-kubernetes"
    }
  )
}
