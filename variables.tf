variable "vpc_cidr" {
    type = string
    description = "this is cidr address"
}

variable "number_of_azs" {
    description = "this is for number of AZs to use"
    type = number
}

variable "restore_to_point_in_time" {
  description = "nested block: NestingList, min items: 0, max items: 1"
  type = set(object(
    {
      restore_time                  = string
      source_db_instance_identifier = string
      source_dbi_resource_id        = string
      use_latest_restorable_time    = bool
    }
  ))
  default = []
}

variable "username" {
  type = string
  description = "username"
}
variable "password" {
  type = string
  description = "password"
}