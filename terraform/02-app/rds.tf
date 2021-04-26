module "rds_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.18.0"

  name        = "secret-app-rds-sg"
  description = "Secret App RDS security group"
  vpc_id      = data.terraform_remote_state.tfstates["vpc"].outputs.vpc.id

  tags = local.tags
}

module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "2.35.0"

  identifier = "app-rds"

  engine            = "mysql"
  engine_version    = "5.7.19"
  instance_class    = "db.t2.large"
  allocated_storage = 5

  name                   = "secretApp"
  username               = "root"
  port                   = "3306"
  create_random_password = true
  random_password_length = 16

  iam_database_authentication_enabled = true

  vpc_security_group_ids = [module.rds_security_group.this_security_group_id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  monitoring_interval    = "30"
  monitoring_role_name   = "MyRDSMonitoringRole"
  create_monitoring_role = true

  tags = local.tags

  subnet_ids = data.terraform_remote_state.tfstates["vpc"].outputs.vpc.database_subnets.ids

  family               = "mysql5.7"
  major_engine_version = "5.7"
  deletion_protection  = true
  storage_encrypted    = true
  multi_az             = true

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    },
  ]
}