# Terraform Multi-region Provisioning Assignment
The assignment was doing the following using modules:
- provision a dynamodb
- create a public and a private subnet with their relevant networking configurations
- place an ec2 instance inside the public subnet
- place a dynamo vpc endpoint in the private subnet
- use s3 bucket as a back-end
What I ended up doing:
- used the following modules to create:
	- [dynamodb](https://github.com/terraform-aws-modules/terraform-aws-dynamodb-table)i never used dynamodb before, so i didn't do much using this module.
	- [vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc) to create multiple subnets and a vpc endpoint with custom policies.
	- [ec2 autoscaling](https://github.com/terraform-aws-modules/terraform-aws-dynamodb-table) in a variable number of availability zones, with a default key
- this [stackoverflow](https://stackoverflow.com/questions/73151159/how-to-re-use-a-terraform-module-in-multiple-configurations) question to cleverly avoid writing everything twice.
## Project Structure
---
##### Tree view of the project:
```
.
├── main.tf
├── provider.tf
├── README.md
├── infrastructure
│   ├── data.tf
│   ├── db.tf
│   ├── ec2_as.tf
│   ├── main.pub
│   ├── network.tf
│   ├── outputs.tf
│   └── variables.tf
├── region_1
│   └── call_module.tf
└── region_2
    └── call_module.tf
```
##### Overview of the code
This project was split into 3 main modules:
- `infrastructure`: where the required infrastructure is created
	- `data.tf`: contains ec2 related data, like filtering the ami to find a suitable image or the ssh key used.
	- `db.tf`: the dynamodb file, i mostly used the default autoscaling example from the module's repo.
	- `ec2_as`: the ec2 autoscaling module, which is redundant because we weren't given an app to deploy.
	- `main.pub`: the public key to use for ssh, again. redundant.
	- `network.tf`: the vpc and vpc endpoint module calls, i've had to sift through the documentation to test dynamodb and ensure it works, i'm sad to announce that i gave up before finding an app to deploy.
	- `outputs.tf`: i just copied the outputs that i want from the documentations of the modules i'm using and you could do it too!
	- `variables.tf`: the variables that interested me during the project, they don't really cover a lot of use cases.
- `region_1` & `region_2`: 
	`call_module.tf` as the name implies, calls the `infrastructure` module, with any modification you want to place on it.
	for example: I wanted to add an ssh `security group` that can be conditionally applied, and after reading the [autoscaling documentation](https://github.com/terraform-aws-modules/terraform-aws-autoscaling?tab=readme-ov-file#input_security_groups) I added the `vpc_id` as an output to the `infrastructure` module so i can create an resource in the `region_1` child module, which gave me an error because it refuses to concatenate an empty array within an empty array with the default created security groups, which i solved by using conditions.
	Now, you can add any security groups you like in either regions.
- `main.tf`:
	This calls the child modules `region_1` & `region_2` with the wanted provider.
##### How to use:
almost everything is defined in the region modules, so you can just clone and run it.

