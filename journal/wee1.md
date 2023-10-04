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
