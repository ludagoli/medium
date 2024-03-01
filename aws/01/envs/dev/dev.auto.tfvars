vpc_name = "basic"
vpc_cidr = "10.1.0.0/16"

vpc_azs             = ["us-east-1a", "us-east-1b"]
vpc_private_subnets = ["10.1.1.0/24", "10.1.2.0/24"]
vpc_public_subnets  = ["10.1.3.0/24", "10.1.4.0/24"]

environment = "dev"

tags = {
  "Terraform" = "true"
  "Environment" = "dev"
}