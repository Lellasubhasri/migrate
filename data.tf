data "aws_route53_zone" "route53" {
  name         = "subhasri.aws.crlabs.cloud"
  private_zone = false  
}


data "aws_availability_zones" "available" {
  state = "available" 
}

data "aws_iam_policy_document" "dms_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["dms.amazonaws.com"]
      type        = "Service"
    }
  }
}

