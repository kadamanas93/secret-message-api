module "rds_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.18.0"

  name        = format("%s-rds-sg", local.name)
  description = "Secret Api RDS security group"
  vpc_id      = data.terraform_remote_state.tfstates["vpc"].outputs.vpc.id

  tags = local.tags
}

resource "aws_security_group_rule" "rds_allow_app" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = module.rds_security_group.this_security_group_id
  source_security_group_id = module.elastic_beanstalk_environment.security_group_id
}