################################################################################
#
################################################################################

output "aws_elasticsearch_domain_endpoint" {
  value = "${aws_elasticsearch_domain.this.endpoint}"
}

output "aws_elasticsearch_domain_domain_name" {
  value = "${aws_elasticsearch_domain.this.domain_name}"
}

output "aws_elasticsearch_domain_domain_id" {
  value = "${aws_elasticsearch_domain.this.domain_id}"
}

output "aws_elasticsearch_domain_arn" {
  value = "${aws_elasticsearch_domain.this.arn}"
}

output "aws_elasticsearch_domain_kibana_endpoint" {
  value = "${aws_elasticsearch_domain.this.kibana_endpoint}"
}

output "aws_security_group_arn" {
  value = "${aws_security_group.this.arn}"
}

output "aws_security_group_id" {
  value = "${aws_security_group.this.id}"
}

output "aws_security_group_name" {
  value = "${aws_security_group.this.name}"
}
