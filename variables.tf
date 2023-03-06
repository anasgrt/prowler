variable "region" {
  default = "eu-west-1"
}

variable "schedule_expression" {
  default     = "cron(0 12 * * ? *)"
  type        = string
  description = "Cloudwatch event rule expression triggered every day at 12:00pm UTC /NOT Netherlands time zone/"
}

# this is the region variable for prowler executing command
variable "default_region" {
  default     = ""
  type        = string
  description = "default AWS region for Prowler Security Assessment"
}
variable "prowler_version" {
  default     = ""
  type        = string
  description = "Prowler Release Installation Version"
}


