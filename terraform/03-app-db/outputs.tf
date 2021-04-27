output "db" {
  value = {
    endpoint = module.db.this_db_instance_endpoint
  }
}

output "beanstalk" {
  value = {
    endpoint = module.elastic_beanstalk_environment.endpoint
    hostname = module.elastic_beanstalk_environment.hostname
  }
}