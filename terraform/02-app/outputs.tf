output "rds" {
  value = {
    addr = module.db.this_db_instance_address
    sg   = module.rds_security_group.this_security_group_id
  }
}