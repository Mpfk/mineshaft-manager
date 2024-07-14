# mineshaft-manager ⛏️

Serverless app for managing a Minecraft server

## What does it do?

This project deploys a minecraft server and web app. The web app allows easy control and configuration of the server.

1. Deploy Mineshaft Manager through CodeCommit and Amplify
2. Launch a Minecraft Server
3. [Optional] Configure a custom domain through Route 53

Feel free to fork and add additional module which tie into your application.

## Table of Contents

- [Dependencies](#dependencies)
- [Directory Structure](#directory-structure)
- [Configure AWS Credentials](#configure-aws-credentials)
- [Prerequisites](#prerequisites)
- [Deployment](#deployment)
- [Clean up](#clean-up)
- [Variables](#variables)
- [Outputs](#outputs)

## Dependencies

This project depends on the `minecraft-spot-pricing` Cloud Formation Template created by GitHub user `vatertime`. Terraform will automatically pull the template from github, save it to an S3 bucket, and use the default values for the parameters when it deploys. Check out the original template here: [vatertime/minecraft-spot-pricing](https://github.com/vatertime/minecraft-spot-pricing/tree/master)

## Directory Structure

The project is structured is as follows:

```
.
├── applications/
│   └── webApp/
│       └── index.html
├── infrastructure/
│   ├── main.tf
│   ├── modules/
│       ├── minecraftServer/
│       │   ├── cloudformation.tf
│       │   └── variables.tf
│       └── webApp/
│           ├── amplify.tf
│           ├── credentials.tf
│           ├── domain.tf
│           ├── outputs.tf
│           ├── repository.tf
│           └── variables.tf
│   └── variables.tf
├── LICENSE
└── README.md
```

## Prerequisites

Before getting started with the deployment, make sure you have the following prerequisites:

- An [AWS account](https://aws.amazon.com/free/) with appropriate permissions to create resources.
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html#getting-started-install-instructions) installed on your local machine.
- [Terraform](https://developer.hashicorp.com/terraform/downloads) installed on your local machine.
- [Git](https://git-scm.com/downloads) installed on your local machine.

## Configure AWS Credentials

Before applying changes to the infrastructure, ensure you are logged in to the AWS Command Line Interface (CLI) with the correct profile. 

```sh
aws configure
```

### IAM Identity Center (SSO)

If you want to connect to an AWS Organization through IAM Identity Center, use:

```sh
aws sso configure
```

If your temporary credentials have expired, use the following to log back in:

```sh
aws sso login --profile <profile_name>
```

## Deployment

To deploy the infrastructure, follow these steps:

1. Clone this repository.

2. Initialize Terraform:

```sh
cd infrastructure/
terraform init
```

3. Plan the deployment to review the changes, capturing variables in a `terraform.tfplan` file:

```sh
terraform plan -out=terraform.tfplan
```

4. Apply the changes to deploy the infrastructure:

```sh
terraform apply "terraform.tfplan"
```

## Clean up

If you want to permanently delete the resources created by Mineshaft Manager, destroy the deployed infrastructure with the following command:

```sh
terraform destroy
```

## Variables

The following variables are required:

- [`aws_region`]: The AWS region to deploy resources in.
- [`aws_profile`]: The AWS CLI profile to use.
- [`project`]: The project name to use as a prefix for resource names.

While these variables are optional:

- ['custom_domain']: Creates a Hosted Zone in Route 53 and configuration in Amplify (DEFAULT: `NULL`).
- ['prod_subdomain']: The subdomain for the production branch (DEFAULT: `NULL`).
- ['dev_subdomain']: The subdomain for the development branch (DEFAULT: `dev`).

## Outputs

The project generates the following outputs:

- `repository_url`: The URL of the CodeCommit repository.
- `amplify_app_id`: The ID of the Amplify app.

## Disclaimer

This is a peronal project I'm making available to others. This is not an official AWS repository, and the code posted here is my own. If you'd like to contribute, submit a pull request. Thanks for stopping by! :)
