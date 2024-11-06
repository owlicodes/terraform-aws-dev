# Terraform AWS EC2 Dev Instance

This is a terraform project that spins up an AWS EC2 instance, the instance will install docker automatically and will setup a local config in the local machine so you can ssh using VSCode.

## Commands

Check the resources.

```bash
terraform plan
```

List the states.

```bash
terraform state list
```

Apply Resources

```bash
terraform apply
```

Replace the ssh config file, you need to list the state first, get the name of the aws ec2 instance and place it after -replace command.

```bash
terraform apply -replace {name_of_ec2_instance}
```

Destory all the resources created.

```bash
terraform destroy
```
