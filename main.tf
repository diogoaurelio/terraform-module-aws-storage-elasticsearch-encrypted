################################################################################
# AWS Security Group
################################################################################

resource "aws_security_group" "this" {
  name        = "${var.environment}-${var.project}-es-${var.domain_name}-sg"
  description = "${var.environment} ${var.domain_name} ElasticSearch Security Group"
  vpc_id      = "${var.vpc_id}"

  tags {
    Environment = "${var.environment}"
    Project     = "${var.project}"
    Name        = "es-${var.domain_name}-sg"
  }
}

# Allow egress traffic
resource "aws_security_group_rule" "this" {
  security_group_id = "${aws_security_group.this.id}"
  from_port         = "${var.egress_from_port}"
  to_port           = "${var.egress_to_port}"
  protocol          = "${var.egress_protocol}"
  cidr_blocks       = ["${var.egress_cidr}"]
  type              = "egress"
}

################################################################################
# AWS ElasticSearch
################################################################################

resource "aws_elasticsearch_domain" "this" {
  domain_name           = "${var.environment}-${var.project}-${var.domain_name}"
  elasticsearch_version = "${var.elasticsearch_version}"
  advanced_options      = "${var.advanced_options}"

  ebs_options {
    ebs_enabled = "${var.ebs_volume_size > 0 ? true : false}"
    volume_size = "${var.ebs_volume_size}"
    volume_type = "${var.ebs_volume_type}"
    iops        = "${var.ebs_iops}"
  }

  encrypt_at_rest {
    enabled    = "${var.encrypt_at_rest_enabled}"
    kms_key_id = "${var.encrypt_at_rest_kms_key_id}"
  }

  cluster_config {
    instance_count           = "${var.instance_count}"
    instance_type            = "${var.instance_type}"
    dedicated_master_enabled = "${var.dedicated_master_enabled}"
    dedicated_master_count   = "${var.dedicated_master_count}"
    dedicated_master_type    = "${var.dedicated_master_type}"
    zone_awareness_enabled   = "${var.zone_awareness_enabled}"
  }

  vpc_options {
    security_group_ids = ["${aws_security_group.this.id}"]
    subnet_ids         = ["${var.subnet_ids}"]
  }

  snapshot_options {
    automated_snapshot_start_hour = "${var.automated_snapshot_start_hour}"
  }

  log_publishing_options {
    enabled                  = "${var.log_publishing_enabled}"
    log_type                 = "${var.log_publishing_log_type}"
    cloudwatch_log_group_arn = "${var.log_publishing_cloudwatch_log_group_arn}"
  }

  tags {
    Environment = "${var.environment}"
    Project     = "${var.project}"
    Name        = "${var.domain_name}"
  }
}

data "aws_iam_policy_document" "this" {
  statement {
    actions = ["${distinct(compact(var.iam_actions))}"]

    resources = [
      "${aws_elasticsearch_domain.this.arn}",
      "${aws_elasticsearch_domain.this.arn}/*",
    ]

    principals {
      type        = "AWS"
      identifiers = ["${distinct(compact(var.iam_role_arns))}"]
    }
  }
}

resource "aws_elasticsearch_domain_policy" "default" {
  count           = "${var.aws_elasticsearch_domain_policy_enabled == "true" ? 1 : 0}"
  domain_name     = "${var.domain_name}"
  access_policies = "${data.aws_iam_policy_document.this.json}"
}
