data "aws_ami" "ami" {
  most_recent         = true
  owners              = ["973714476881"]

  filter {
    name   = "name"
    values = ["Centos-7-DevOps-Practice"]
  }

}

data "aws_secretsmanager_secret" "secrets" {
  name                = "roboshop-${var.ENV}"
}

data "aws_secretsmanager_secret_version" "creds" {
  secret_id = data.aws_secretsmanager_secret.secrets.id
}


