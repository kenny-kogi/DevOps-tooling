variable "tags" {}
variable "public_subnets" {}
variable "vpc_id" {}


variable "jenkins_props" {
  type = object({
    ami = string
    bastion_instance_type = string
    aws_key_pair = string
  })
}
