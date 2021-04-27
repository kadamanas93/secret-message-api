output "db" {
  value = {
    endpoint = module.db.this_db_instance_endpoint
  }
}