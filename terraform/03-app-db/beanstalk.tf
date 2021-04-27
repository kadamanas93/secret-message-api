module "elastic_beanstalk_application" {
  source  = "cloudposse/elastic-beanstalk-application/aws"
  version = "0.11.0"

  namespace   = var.namespace
  stage       = var.stage
  name        = var.name
  description = "Elastic BeanStalk Secret API Application"

  tags = local.tags
}

resource "aws_elastic_beanstalk_application_version" "secret_app" {
  name        = format("%s-eb-app-version", local.name)
  application = module.elastic_beanstalk_application.elastic_beanstalk_application_name
  description = "Secret Api Application Version"
  bucket      = aws_s3_bucket.secret_app_s3.id
  key         = aws_s3_bucket_object.docker_json_object.id

  tags = local.tags
}

module "elastic_beanstalk_environment" {
  source  = "cloudposse/elastic-beanstalk-environment/aws"
  version = "0.39.0"

  namespace                          = var.namespace
  stage                              = var.stage
  name                               = var.name
  description                        = "Elastic BeanStalk Secret API Environment"
  region                             = var.region
  availability_zone_selector         = "Any 2"
  elastic_beanstalk_application_name = module.elastic_beanstalk_application.elastic_beanstalk_application_name

  instance_type           = "t3.small"
  autoscale_min           = 1
  autoscale_max           = 2
  updating_min_in_service = 0
  updating_max_batch      = 1

  loadbalancer_type       = "application"
  healthcheck_url         = "/health"
  vpc_id                  = data.terraform_remote_state.tfstates["vpc"].outputs.vpc.id
  loadbalancer_subnets    = data.terraform_remote_state.tfstates["vpc"].outputs.vpc.public_subnets.ids
  application_subnets     = data.terraform_remote_state.tfstates["vpc"].outputs.vpc.private_subnets.ids
  allowed_security_groups = []

  prefer_legacy_service_policy = false

  solution_stack_name = "64bit Amazon Linux 2018.03 v2.16.7 running Docker 19.03.13-ce"
  version_label       = aws_elastic_beanstalk_application_version.secret_app.name

  env_vars = {
    DB_USER        = module.db.this_db_instance_username
    DB_PASSWORD    = module.db.this_db_instance_password
    DB_URL         = module.db.this_db_instance_endpoint
    SECRET_MESSAGE = aws_secretsmanager_secret_version.api_secret_message.secret_string
  }

  tags = local.tags
}
