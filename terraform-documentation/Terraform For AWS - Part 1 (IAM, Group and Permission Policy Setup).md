# Learn Terraform For AWS Development Environment

In this documentation, we are going to learn how to setup terraform for your AWS development environment.

## Prerequisites

In order to follow this documentation, make sure you have your AWS account setup.

## Install Terraform

For this documentation, I will be using Windows machine, some shortcuts or machine location might be different for you, depending on which OS you are using.

To download the Terraform Binary, please go to this link https://developer.hashicorp.com/terraform/install. Download the binary, extract the zip file.

To actually use the terraform commands, you need to change directory into the folder where the extracted binary is located. So open a command prompt and cd into the directory that contains the binary, run the command below.

```bash
terraform
```

In order to use terraform commands anywhere on your machine, you need to add the binary location to your environment variables. Put the terraform binary to C:/Program Files/Terraform, note that the location here is just a suggestion, you can put the terraform binary anywhere in your machine.

Now, go to Advance System Settings, clicked the Environment Variables button, edit the path variable, then add a new path and paste the location of the terraform binary.

Once you do this, you should be able to use terraform command anywhere. To test this, open a command prompt, then run the command below.

```bash
terraform
```

This command should display the terraform detailed information. If you encounter an error, please check the you have succesfully modified the environment variables with the correct path.

## Create an IAM User - User Group and Permission Policy

When you create an AWS account, normally your first user will be the root user. As best practice, you need to create an IAM User with Administrative Privileges and not directly use your root user.

The user we will create here will also be the user that we are going to use to set up a credential profile in our VSCode. I will be using VSCode here but feel free to use another code editor. Just note that some of the shortcuts or steps might be different if you are not using VSCode.

Now, let's create an IAM User, in your AWS Console, search for the IAM Service and go that page. It should look something like below.

![IAM Home Page](<images/IAM Home Page.png>)

Before creating the actual user, as part of best practices, let's also create a User Groups where we can add the users we want to give Admin Access to our AWS account. On the left menu panel, click on the **User Groups** menu.

Then, create a new group, you can name it **admin-group** or any name you like. Once this group is created, you can now go to this group, it should be listed in the User Groups Data Table. Once you click it, it will navigate you the details view of this group.

Now, what we want to do here is to add **Permissions** to this group. Navigate to the **Permissions Tab**, here you will see all the available permission policies attached to the User Group. For now you should see empty records. You should also see a button for adding a new policy, click the button so you can attach a new policy.

The policy you should attach to this group is called **AdministratorAccess**. This permission gives the user admin access to your AWS account. You need to be very careful adding users to this group.

Once you add the group and the permission policy, you should see something like below.

![Admin Group Permission Policy](<images/Admin Group Permission Policy.png>)

## Create an IAM User - IAM User

Now that we have our Admin Group with Admin Permission Policy attached to it, we can now create an IAM User, to do this, click the **Users** link in the left side navigation panel, this will navigate you to the Users Page.

Here, you should see a **Create User** button, click that to create a new user. Once you do so, the created user should be available now to the data table.

Next thing we need to do is go back to the **User Groups** page, once you are in User Groups page, you can click the **admin-group** we created earlier, in the **Users** tab, there should be a button for adding a user to this group, click that button and add the user you created in the previous steps. Once you do so, you should see something like below.

![Admin User](<images/Admin User.png>)

## VSCode AWS Credential Profile - Access Keys

In order to setup an AWS Credential Profile in VSCode, you need to generate an AWS Access Key and AWS Secret Key for your IAM User. To do this, go back to IAM Page in AWS Console, in the users page, click the IAM User you created. Once you are in the IAM User Details page, you should see a tab for **Security credentials**, click this tab, you should see an option to create **access keys**. Once you click the create access keys button, you will be able to create a new access key and secret key, please note that your use case should be **Command Line Interface (CLI)** because we are going to use the keys in the command line.

## VSCode AWS Credential Profile - VSCode Extensions

There are helpful VSCode extensions that we can install to help us with AWS and Terrform. Search the extensions **Terraform** and **AWS Toolkit**

## VSCode AWS Credential Profile - Setup AWS Credential Profile

Now, we are ready to setup our AWS Credential Profile, to do this in VSCode, press the command **ctrl + shift + p** and search for **AWS: Create Credential Profile**, choose this command, once you do so, it will ask for your **access key** and **secret key**.

After inputting these keys, a credentials profile will be available in your VSCode and in your Windows Machine.

When you configure a credential profile in your local machine, it is normally saved to C:/Users/{User}/.aws/credentials.

With all your profile setup, we can now start with terraform.
