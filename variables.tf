################################################################################
# Account and Backend
################################################################################

variable "vpc_id" {
  description = "VPC ID where to deploy ES"
}

variable "aws_region" {
  description = "Region to deploy the stack"
  default     = "eu-west-1"
}

variable "environment" {
  description = "Environment of the Stack"
}

variable "project" {
  description = "Specify to which project this resource belongs"
}

variable "egress_protocol" {
  default = "-1"
}

variable "egress_cidr" {
  description = "CIDR to open out going traffic to the SG"
  type        = "list"
  default     = ["0.0.0.0/0"]
}

variable "egress_from_port" {
  description = "Default ports to allow out going traffic in ES Securty Group, to be used in combination with 'egress_to_port' variable"
  default     = 0
}

variable "egress_to_port" {
  description = "Default ports to allow out going traffic in ES Securty Group, to be used in combination with 'egress_from_port' variable"
  default     = 0
}

################################################################################
# ElasticSearch
################################################################################

variable "domain_name" {}

variable "elasticsearch_version" {
  default = "6.3"
}

variable "ebs_volume_size" {
  default = 0
}

variable "ebs_volume_type" {
  default = "gp2"
}

variable "ebs_iops" {
  default = 0
}

variable "encrypt_at_rest_enabled" {
  default = false
}

variable "instance_count" {
  default = 1
}

variable "instance_type" {
  default = "t2.medium.elasticsearch"
}

variable "dedicated_master_enabled" {
  description = "Whether or not to isolate master nodes in dedicated instances or not"
  default     = false
}

variable "dedicated_master_count" {
  default = 3
}

variable "dedicated_master_type" {
  description = "Instance type for the dedicated node for the role 'master' (only valid if dedicated_master_enabled is set to true)"
  default     = "t2.medium.elasticsearch"
}

variable "zone_awareness_enabled" {
  description = "To enable zone awareness to deploy Elasticsearch nodes into two different Availability Zones, you need to set zone_awareness_enabled to true and provide at least two different subnets in subnet_ids"
  default     = false
}

variable "advanced_options" {
  type    = "map"
  default = {}
}

variable "encrypt_at_rest_kms_key_id" {
  description = "The KMS key id to encrypt the Elasticsearch domain with. If not specified, then it defaults to using the AWS/Elasticsearch service KMS key"
  default     = ""
}

variable "subnet_ids" {
  description = "List of subnet Ids where ElasticSearch cluster should work"
  type        = "list"
  default     = []
}

variable "automated_snapshot_start_hour" {
  description = "Hour at which automated snapshots are taken, in UTC"
  default     = 3
}

variable "log_publishing_enabled" {
  type        = "string"
  default     = "false"
  description = "Specifies whether log publishing option is enabled or not"
}

variable "log_publishing_log_type" {
  type        = "string"
  default     = "SEARCH_SLOW_LOGS"
  description = "A type of Elasticsearch log. Valid values: INDEX_SLOW_LOGS, SEARCH_SLOW_LOGS"
}

variable "log_publishing_cloudwatch_log_group_arn" {
  type        = "string"
  default     = ""
  description = "ARN of the Cloudwatch log group to which log needs to be published"
}

variable "iam_actions" {
  type        = "list"
  default     = []
  description = "List of actions to allow for the IAM roles, _e.g._ `es:ESHttpGet`, `es:ESHttpPut`, `es:ESHttpPost`"
}

variable "iam_role_arns" {
  type        = "list"
  default     = []
  description = "List of IAM role ARNs to permit access to the Elasticsearch domain"
}

variable "aws_elasticsearch_domain_policy_enabled" {
  type        = "string"
  default     = "false"
  description = "Whether or not to create ElasticSearch domain policy or not"
}
