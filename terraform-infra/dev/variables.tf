variable "aws_profile" {}
variable "tf_state_bucket" {}
variable "tf_role_arn" {}
variable "account" {}
variable "env_prefix" {}
variable "branch" {}
variable "openvpn_security_group_id" {}
variable "openvpn_elastic_ip" {}


variable "region" {}

variable "public_subnet_cidrs" {
  type = list(string)
  description = "Public Subnet CIDR values"
}

variable "private_subnet_cidrs" {
  type = list(string)
  description = "Private Subnet CIDR values"
}

variable "azs" {
  type = list(string)
  description = "Availability Zones"
}

variable "repos" {
  type = object({
    library_api = string
  })
}

variable "jenkins_properties" {
  type = object({
    ami = string
    bastion_instance_type = string
    aws_key_pair = string
  })
}

