# Learn Terraform For AWS Development Environment

In this documentation, we are going to learn how to setup terraform for your AWS development environment.

## Prerequisites

In order to follow this documentation, make sure you have your AWS account setup.

Also, you should have done the first part of this documentation.

## Creating an AWS Provider using Terraform

With Terraform, we can now create an AWS Provider using the credentials we created in the first part of this documentation. Create a new folder called aws-terraform to any location in your windows machine, open it with VSCode, this folder is our workspace folder where we will put all our terraform templates.

Create a file called **providers.tf** and paste the code below. This will allow us to talk to our AWS Account using Terraform.

```terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "default"
}
```

The version for the provider might change, you can also modify the region you want to use, for more information, you can visit the terraform documentation specifically for aws by going to this link https://registry.terraform.io/providers/hashicorp/aws/latest/docs.

Save the file and run the command below.

```bash
terraform init
```

This will initialize terraform and use your aws information.

## Creating a VPC

We are going to create a development VPC, create a new file called main.tf, and paste the code below. This will create a new VPC called dev in our AWS account, again, for more information, visit the documentation.

```terraform
resource "aws_vpc" "mtc_vpc" {
  cidr_block = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "dev"
  }
}
```

To check what are all the resources that our terraform template will create for us, we can run the command below.

```bash
terraform plan
```

To create the resources, we can now run the command below.

```bash
terraform apply
```

To verify that the VPC is created, you can check it in your AWS Console by going to the VPC Services. Or in your VSCode, you can select the AWS Extension in the left panel, expand the **EXPLORER** and look for **Resources**. If you don't see the VPC here, press **Gear** icon when you hover over the Resources menu, search for **VPC** and check it, then press **OK**, once done, you should be able to see the available VPCs in your AWS account from your VSCode just like the image below.

![VSCode VPC Resources](<images/VSCode VPC Resources.png>)

## Terraform State

Whenever you apply a terraform template, terraform will store a state for you. This state is used by Terraform to map real world resources to your configuration, keep track of metadata, and to improve performance for large infrastructures.

To check the list of states, you can run the command below.

```bash
terraform state list
```

To check the details of a specific state, you can run the command below.

```bash
terraform state show aws_vpc.mtc_vpc
```

Here, we want to display the details of aws_vpc.mtc_vpc, this is the vpc we created earlier.

## Terraform Destroy

To remove all of the created resources by terraform, you can run the destroy command.

```bash
terraform destroy
```
