output "vpc" {
  value = {
    id         = module.vpc.vpc_id
    cidr_block = module.vpc.vpc_cidr_block
    private_subnets = {
      ids   = module.vpc.private_subnets
      cidrs = module.vpc.private_subnets_cidr_blocks
    }
    public_subnets = {
      ids   = module.vpc.public_subnets
      cidrs = module.vpc.public_subnets_cidr_blocks
    }
    database_subnets = {
      ids   = module.vpc.database_subnets
      cidrs = module.vpc.database_subnets_cidr_blocks
    }
  }
}
