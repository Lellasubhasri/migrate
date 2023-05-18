// plugin "terraform" {
//   enabled = true
//   version = "1.3.7"
//   source  = "github.com/terraform-linters/tflint"
//   preset  = "recommended"
// }
plugin "terraform" {
    enabled = true
    version = "0.3.0"
    source  = "github.com/terraform-linters/tflint-ruleset-terraform"  
}
plugin "aws" {
  enabled = true
  version = "0.23.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}
// rule "aws_instance_invalid_type" {
//   enabled = false
// }