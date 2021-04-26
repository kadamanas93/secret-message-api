output "vpc" {
  value = {
    id              = module.vpc.vpc_id
    cidr_block      = module.vpc.vpc_cidr_block
    private_subnets = module.vpc.private_subnets
    public_subnets  = module.vpc.public_subnets
  }
}
