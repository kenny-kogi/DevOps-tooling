region = "eu-central-1"
account = ""
env_prefix = "dev"
tf_state_bucket = "de-dev-trf"
env_prefix = "dev"
aws_profile = "default"
branch      =  "development"

public_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24",
  "10.0.3.0/24"]

private_subnet_cidrs = [
  "10.0.4.0/24",
  "10.0.5.0/24",
  "10.0.6.0/24"]

azs = [
  "eu-central-1a",
  "eu-central-1b",
  "eu-central-1c"]


repos = {
  library_api                             = "koko/library_api"
}

jenkins_properties = {
  ami = "ami-06ce824c157700cd2"
  bastion_instance_type = "m5.2xlarge"
  aws_key_pair = "jenkins"
}


