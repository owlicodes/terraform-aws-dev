# Learn Terraform For AWS Development Environment

In this documentation, we are going to learn how to setup terraform for your AWS development environment.

## Prerequisites

In order to follow this documentation, make sure you have your AWS account setup.

Also, you should have done the first part, second part and third part of this documentation.

## Create Security Group

To create a security group, copy the code below and paste it in your main.tf file.

```terraform
resource "aws_security_group" "mtc_security_group" {
  name        = "dev-security-group"
  description = "Security group for development environment."
  vpc_id      = aws_vpc.mtc_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```

Run the plan and apply command once you are happy with the changes. You can run the fmt command as well to format the file.
