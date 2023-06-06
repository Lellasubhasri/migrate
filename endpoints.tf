# target endpoint

resource "aws_dms_endpoint" "test" {
  database_name               = "mydb"
  endpoint_id                 = "endpoint-target"
  endpoint_type               = "target"
  engine_name                 = "aurora"
   username                   = var.username
  password                    = var.password
  port                        = 5432
  server_name                 = "test"
  ssl_mode                    = "none"
 #kms_key_arn                  = "default"
  tags = {
    Name = "endpoint-target"
  }
}
data "aws_instance" "data_server" {
  instance_id = "i-0c82884bfd3788141"
  filter {
    name   = "image-id"
    values = ["ami-0ab1a82de7ca5889c"]
  }

  filter {
     name   = "tag:Name"
    values = ["dataserver"]
  }
}

#source endpoint
resource "aws_dms_endpoint" "sou" {
  database_name               = "customer_db"
  endpoint_id                 = "endpoint-source"
  endpoint_type               = "source"
  engine_name                 = "mysql"
  username                    = "phpmyadmin"
  password                    = "rootpassword"
  port                        = 3306
  server_name                 = data.aws_instance.data_server.private_ip
  
 #kms_key_arn                  = "default"
  tags = {
    Name = "endpoint-source"
  }

}
