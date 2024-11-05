# Common variables
variable "name_prefix" {
  description = "Name prefix for resources"
  type        = string
  default     = ""
}

# variable "custom_tags" {
#   description = "Custom tags which can be passed on to the AWS resources. They should be key value pairs having distinct keys"
#   type        = map(any)
#   default     = {}
# }

variable "env" {
  description = "A logical name to env for which resources are created. Stage, e.g. 'dev', 'uat', 'prod'."
  type        = string
}

variable "team_abbrv" {
  description = "The team abbreviation"
  type        = string
  default     = "dev"
}

variable "purpose" {
  description = "The purpose of the resource"
  type        = string
  default     = "dev"
}


# ---------------------------------------
# S3 bucket variables
variable "acl" {
  description = "The canned ACL to apply to the S3 bucket (Ref: https://docs.aws.amazon.com/AmazonS3/latest/userguide/acl-overview.html)"
  type        = string
  default     = "null"
}

variable "force_destroy" {
  description = "Force destruction of the S3 bucket when the stack is deleted"
  type        = bool
  default     = false
}

variable "versioning_enabled" {
  description = "Should versioning be enabled? (Enabled/Suspended/Disabled)"
  type        = string
  default     = "Disabled"
}

variable "expiration_days" {
  description = "Number of days after which data will be automatically destroyed. Defaults to 0 meaning expiration is disabled"
  type        = number
  default     = 0
}