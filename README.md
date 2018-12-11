Terraform AWS module for ElasticSearch encrypted
================================================

Generic repository for a terraform module for AWS ElasticSearch encrypted database using KMS key

![Image of Terraform](https://i.imgur.com/Jj2T26b.jpg)

# Table of content

- [Introduction](#intro)
- [Usage](#usage)
- [Release log](#release-log)
- [Module versioning & git](#module-versioning-&-git)
- [Local terraform setup](#local-terraform-setup)
- [Authors/Contributors](#authorscontributors)


# Intro

Module that creates:
- AWS security group and egress rule for a given parameterized CIDR
- AWS Elasticsearch policy
- AWS Elasticsearch domain inside a given VPC id

Optionally encrypts at rest data in Elasticsearch using an externally created KMS key. Please inject those with variables:
- encrypt_at_rest_kms_key_id = "kms-key-id"
- encrypt_at_rest_enabled = true


# Usage

Example usage:

```hcl

module "elasticsearch" {

  source                                  = "github.com/diogoaurelio/terraform-module-aws-storage-elasticsearch-encrypted"
  version                                 = "v0.0.1"

  domain_name                             = "search"
  vpc_id                                  = "vpc-123"
  aws_region                              = "eu-west-1"
  environment                             = "dev"
  project                                 = "relevance"
  instance_count                          = 1
  instance_type                           = "t2.medium.elasticsearch"
  ebs_volume_size                         = 20

  # Note: You must specify exactly one subnet (with one node at least)
  subnet_ids                              = ["subnet-123"]
  aws_elasticsearch_domain_policy_enabled = true
  iam_actions                             = ["es:*"]
  iam_role_arns                           = ["*"]
}

```


# Release log

Whenever you bump this module's version, please add a summary description of the changes performed, so that collaboration across developers becomes easier.

* version v0.0.1 - first module release

# Module versioning & git

To update this module please follow the following proceedure:

1) make your changes following the normal git workflow
2) after merging the your changes to master, comes the most important part, namely versioning using tags:

```bash
git tag v0.0.2
```

3) push the tag to the remote git repository:
```bash
git push origin master tag v0.0.2
```

# Local terraform setup

* [Install Terraform](https://www.terraform.io/)

```bash
brew install terraform
```

* In order to automatic format terraform code (and have it cleaner), we use pre-commit hook. To [install pre-commit](https://pre-commit.com/#install).
* Run [pre-commit install](https://pre-commit.com/#usage) to setup locally hook for terraform code cleanup.

```bash
pre-commit install
```


# Authors/Contributors

See the list of [contributors](https://github.com/diogoaurelio/terraform-module-aws-storage-elasticsearch-encrypted/graphs/contributors) who participated in this project.
