data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_instance" "jenkins" {
  ami = "ami-0f62e5a363d54d073"
  instance_type = var.jenkins_props.bastion_instance_type
  subnet_id = var.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.jenkins-sg.id]
  availability_zone = data.aws_availability_zones.available.names[0]
  key_name = var.jenkins_props.aws_key_pair
  user_data = "${path.module}/jenkins-config/jenkins-userdata.sh"
  
    tags = merge(
    var.tags,
    {
      "Name" = "${var.tags.env_prefix}-jenkins"
    }
  )
}
