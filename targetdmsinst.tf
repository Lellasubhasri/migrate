resource "aws_dms_replication_subnet_group" "replication_subnet_group" {
  replication_subnet_group_description = "Replication subnet group"
  replication_subnet_group_id          = "dms-replication-subnet-group"

  subnet_ids = [module.vpc.database_subnets[0], module.vpc.database_subnets[1]]

  tags = {
    Name = "replication-subnet-group"
  }
}

resource "aws_dms_replication_instance" "targetdms" {
  allocated_storage            = 20
  apply_immediately            = true
  auto_minor_version_upgrade   = true
  availability_zone            = local.availability_zones[0]
  #engine                      = "mysql"
  engine_version               = "3.4.7"
  multi_az                     = false
  preferred_maintenance_window = "sun:10:30-sun:14:30"
  publicly_accessible          = true
  replication_instance_class   = "dms.t3.micro"
  replication_subnet_group_id = aws_dms_replication_subnet_group.replication_subnet_group.id
  replication_instance_id = "dms-replication-subnet-group"
  tags = {
    Name = "targetdms"
  }

  vpc_security_group_ids = [aws_security_group.targetserver.id]

  depends_on = [
    aws_iam_role_policy_attachment.dms-access-for-endpoint-AmazonDMSRedshiftS3Role,
    aws_iam_role_policy_attachment.dms-cloudwatch-logs-role-AmazonDMSCloudWatchLogsRole,
    aws_iam_role_policy_attachment.dms-vpc-role-AmazonDMSVPCManagementRole
  ]
}


