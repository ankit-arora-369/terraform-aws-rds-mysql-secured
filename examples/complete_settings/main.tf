module "rds_mysql" {
  source            = "../../"
  identifier        = "example"
  engine_version    = "5.7.28"
  instance_class    = "db.t2.small"
  allocated_storage = 20
  username          = "root"
  password          = "YouShouldChangePasswordAfterApply!"

  subnet_ids         = var.subnets
  vpc_id             = var.vpc_id
  source_cidr_blocks = var.source_cidr_blocks

  maintenance_window                  = "mon:12:30-mon:12:50"
  backup_window                       = "09:30-10:00"
  apply_immediately                   = false
  multi_az                            = ture
  port                                = 3306
  name                                = "example"
  storage_type                        = "gp2"
  iops                                = 0
  auto_minor_version_upgrade          = false
  allow_major_version_upgrade         = false
  backup_retention_period             = 0
  storage_encrypted                   = true
  kms_key_id                          = ""
  deletion_protection                 = true
  final_snapshot_identifier           = "rds-snapshot"
  skip_final_snapshot                 = true
  enabled_cloudwatch_logs_exports     = []
  monitoring_interval                 = 0
  monitoring_role_arn                 = ""
  iam_database_authentication_enabled = false
  copy_tags_to_snapshot               = false
  publicly_accessible                 = true
  license_model                       = "general-public-license"
  major_engine_version                = "5.7"
  description                         = "Enter description here."

  tags = {
    Environment = "prod"
  }
}

module "vpc" {
  source                    = "git::https://github.com/tmknom/terraform-aws-vpc.git?ref=tags/2.0.1"
  cidr_block                = local.cidr_block
  name                      = "vpc-rds-mysql"
  public_subnet_cidr_blocks = [cidrsubnet(local.cidr_block, 8, 0), cidrsubnet(local.cidr_block, 8, 1)]
  public_availability_zones = data.aws_availability_zones.available.names
}

locals {
  cidr_block = "10.255.0.0/16"
}

data "aws_availability_zones" "available" {}
