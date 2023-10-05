# Terraform Beginner Bootcamp 2023 week0 - Week 1

## Root modules structure

Our root module structure is as follows

```
PROJECT_ROOT
|
├── variables.tf       #stores the structure of input variables or where we declare our variables
├── main.tf            #everything else
├── providers.tf       #defines required providers and their configurations
├── outputs.tf         #stores our outputs
├── terraform.tfvars   #the data of variables we want to load into our Terraform project or where we define our variables
└── README.md          #required for root modules
```

[Standard Modue Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform input variables
## Terraform Cloud Variables
In terraform we can set two kind of variables:

- Enviroment Variables - those you would set in your bash terminal eg. AWS credentials
- Terraform Variables - those that you would normally set in your tfvars file

We can set Terraform Cloud variables to be sensitive so they are not shown visibliy in the UI.

## Loading Terraform Input Variables

## -var
We can use the `-var` flag to to set an input variable or override a variable in the tfvars flag eg. `terraform -var user_uuid="my_user_id"`

[var-flag flag](https://build5nines.com/use-terraform-input-variables-to-parameterize-infrastructure-deployments/#:~:text=lower(var.location)%0A%7D-,Pass%20Input%20Variables%20to%20Terraform%20Deployments,-Input%20Variables%20in)

The `-var-file` flag is used to pass Input Variable values into Terraform plan and apply commands using a file that contains the values.

## terraform.tvfars
[To set lots of variables](https://developer.hashicorp.com/terraform/language/values/variables#:~:text=several%20different%20variables.-,Variable%20Definitions%20(.tfvars)%20Files,-To%20set%20lots)

This is the default file to load in terraform variables in blunk

## auto.tfvars
[auto.tfvars](https://www.google.com/search?q=use+of+auto.tfvars+in+terraform&oq=use+of+auto.tfvars+in+terraform&gs_lcrp=EgZjaHJvbWUyBggAEEUYOTIHCAEQIRigATIKCAIQIRgWGB0YHjIKCAMQIRgWGB0YHjIKCAQQIRgWGB0YHjIKCAUQIRgWGB0YHjIKCAYQIRgWGB0YHjIKCAcQIRgWGB0YHjIKCAgQIRgWGB0YHjIKCAkQIRgWGB0YHtIBCDcwNTNqMGo0qAIAsAIA&sourceid=chrome&ie=UTF-8#:~:text=Terraform%20also%20automatically%20loads%20a%20number%20of%20variable%20definitions%20files%20if%20they%20are%20present%3A)

You can define variable overrides in a file named terraform.tfvars or any file ending in .auto.tfvars.


[order of terraform variables](https://developer.hashicorp.com/terraform/language/values/variables#:~:text=Variable%20Definition%20Precedence)

The order of precedence for variable sources is as follows with later sources taking precedence over earlier ones:

  - Environment variables # Keep the variables.tf and terraform.tfvars without any modification.
  - The terraform.tfvars file, if present. # 
Create a `auto.tfvars` file with the following content. I will name my file `rudolph.auto.tfvars`

  - The terraform.tfvars.json file, if present. # 

  - Any `*.auto.tfvars` or `*.auto.tfvars.json` files, processed in lexical order of their filenames.

  - Any `-var` and `-var-file` options on the command line, in the order they are provided.

## Dealing with Configuration Drift

## What happens if we lose our state file

If you lose your statefile, you most likley have to tear down all your cloud infrastructure manually.

You can use terraform port but it won't for all cloud resources. You need check the terraform providers documentation for which resources support import.

### Fix Missing Resource with Terraform Import

`terraform import aws_s3_bucket.bucket bucket-name`

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)

### Fix Manual Configuration

When any resource created terraform is modified or deleted by hand, if we run `terraform plan` it will attempt to put our infrastructure back nto the expected state fixing Configuration Drift. 

## Fix using Terraform refresh
```sh
terraform apply -refresh-only -auto-approve
```

## Terraform modules

### Terraform modules structure

It is recomended to place modules in a `module` directory when developing locally but you can name it whatever you like.

### Pasing input variables

We can pass input variables to our modules.
The modules has to declare the terraform module in it's own `variable.tf`

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```


### Modules sources

Using the source we can import the modules from various palces eg:
- locally
- Github
- Terraform Registry

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
}
```

## Considerations when using ChatGPT to write Terraform modules.

LLMs such as ChatGPT may not be trained on the latest documentation or information about terraform.
It may like;y produce older examples that could be deprcated. Often affecting providers.

## Working with files in terraform

### Fileexist function

This is a built in terraform function to check the exixtance of a file

```
condition = fileexist(var.error_html_filepath)
```

[fileexists Function](https://developer.hashicorp.com/terraform/language/functions/fileexists)

### Filemd5

[filemd5 Function](https://developer.hashicorp.com/terraform/language/functions/filemd5)

### Path Variable

In Terraform there is a special variable called `path` that allows us to reference local paths:
 - path.module = get the path for the current module
 - path.root = get the path for the root module


```tf
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"
}
```
[Special Path Variables](https://developer.hashicorp.com/terraform/language/expressions/references#:~:text=a%20data%20resource.-,Filesystem%20and%20Workspace%20Info,-The%20following%20values)

## Terraform Locals

Locals allows us to define local variables. It can be very useful when we need transform data into another format and have referenced a varaible.

```tf
locals {
  s3_origin_id = "MyS3Origin"
}
```

[Local Values](https://developer.hashicorp.com/terraform/language/values/locals#:~:text=v1.6.x%20(latest)-,Local%20Values,-Hands%2Don%3A)


### Terraform Data Sources


This allows us to source data from cloud resources.

This is useful when we want to reference cloud resources without importing them

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

```
[Data Sources](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity#:~:text=Data%20Source%3A%20aws_caller_identity)
or 
[this](https://developer.hashicorp.com/terraform/language/data-sources#:~:text=v1.6.x%20(latest)-,Data%20Sources,-Data%20sources%20allow)


## Working With Jason

The `jasonencode` is used to create the json policy inline in `hcl`

```json
jsonencode({"hello"="world"})
{"hello":"world"}

```

[jsonencode Function](https://developer.hashicorp.com/terraform/language/functions/jsonencode#:~:text=v1.6.x%20(latest)-,jsonencode%20Function,-jsonencode%20encodes%20a)









