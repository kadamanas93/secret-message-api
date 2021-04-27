resource "aws_s3_bucket" "secret_app_s3" {
  bucket = format("%s-docker-s3", local.name)
  acl    = "private"

  tags = local.tags
}

data "template_file" "docker_json" {
  template = file("./Dockerrun.aws.json.tpl")
  vars = {
    ecr_url = data.terraform_remote_state.tfstates["ecr"].outputs.app_ecr_url
  }
}

resource "aws_s3_bucket_object" "docker_json_object" {
  bucket  = aws_s3_bucket.secret_app_s3.id
  key     = "Dockerrun.aws.json"
  content = data.template_file.docker_json.rendered

  tags = local.tags
}
