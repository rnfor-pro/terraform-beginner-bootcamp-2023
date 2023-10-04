# Terraform Beginner Bootcamp 2023

## Table of Contents

- [Semantic Versioning](#semantic-versioning)
- [Install the Terraform CLI](#install-the-terraform-cli)
  - [Considerations with the Terraform CLI changes](#considerations-with-the-terraform-cli-changes)
  



## Semantic versioning :mage: 

This project is going to utilize semantic versioning or it's tagging.
[semver.org]https://semver.org/

The general format:

**MAJOR.MINOR.PATCH**, e.g `1.0.1`

- ***MAJOR*** version when you make incompatible API changes
- ***MINOR*** version when you add functionality in a backward compatible manner
- ***PATCH*** version when you make backward compatible bug fixes

## Install the Terraform CLI

### Considerations with the Terraform CLI changes
The Terraform CLI installation instructions have changed due to gpg keyring changes. So we needed refer to the latest install CLI instructions via Terraform Documentation and change the scripting for install.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)


### Considerations for Linux Distribution

This project is built against Ubunutu OS.
Please make sure you check your Linux Distrubtion and change accordingly to distrubtion needs. 

[How To Check OS Version in Linux](
https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of checking OS Version:

```
$ cat /etc/os-release

PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Refactoring into Bash Scripts

While fixing the Terraform CLI gpg depreciation issues we notice that bash scripts steps were a considerable amount more code. So we decided to create a bash script to install the Terraform CLI.

This bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)

- This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) tidy.
- This allow us an easier to debug and execute manually Terraform CLI install
- This will allow better portablity for other projects that need to install Terraform CLI.

#### Shebang Considerations

A Shebang (prounced Sha-bang) tells the bash script what program that will interpet the script. eg. `#!/bin/bash`

 Format recommended by ChatGPT for bash is: `#!/usr/bin/env bash`

- for portability for different OS distributions 
-  will search the user's PATH for the bash executable

https://en.wikipedia.org/wiki/Shebang_(Unix)

#### Execution Considerations

Use the `./` shorthand notiation to execute the bash script.

eg. `./bin/install_terraform_cli`

If we are using a script in .gitpod.yml  we need to point the script to a program to interpert it.

eg. `source ./bin/install_terraform_cli`

#### Linux Permissions Considerations

In order to make our bash scripts executable we need to change linux permission for the fix to be exetuable at the user mode.

```sh
chmod u+x ./bin/install_terraform_cli
```

alternatively:

```sh
chmod 744 ./bin/install_terraform_cli
```

https://en.wikipedia.org/wiki/Chmod

## Gitpod Lifecycle

We need to be careful when using the Init because it will not rerun if we restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/tasks


## Working Env Vars

### env command

We can list out all Enviroment Variables (Env Vars) using the `env` command

We can filter specific env vars using grep eg. `env | grep AWS_`

### Setting and Unsetting Env Vars

In the terminal we can set using `export HELLO='world`

In the terrminal we unset using `unset HELLO`

We can set an env var temporarily when just running a command

```sh
HELLO='world' ./bin/print_message
```
Within a bash script we can set env without writing export eg.

```sh
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```

### Printing Vars

We can print an env var using echo eg. `echo $HELLO`

### Scoping of Env Vars

When you open up new bash terminals in VSCode it will not be aware of env vars that you have set in another window.

If you want to Env Vars to persist across all future bash terminals that are open you need to set env vars in your bash profile. eg. `.bash_profile`

### Persisting Env Vars in Gitpod

We can persist env vars into gitpod by storing them in Gitpod Secrets Storage.

```
gp env HELLO='world'
```

All future workspaces launched will set the env vars for all bash terminals opened in those workspaces.

You can also set en vars in the `.gitpod.yml` but this can only contain non-senstive env vars.


## AWS CLI Installation

AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)


[Getting Started Install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS credentials is configured correctly by running the following AWS CLI command:
```sh
aws sts get-caller-identity
```

If it is succesful you should see a json payload return that looks like this:

```json
{
    "UserId": "AIEAVUO15xxxxxxxxxx",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/terraform-beginner-bootcamp"
}
```

We'll need to create an IAM user and generate AWS CLI credentials.




## Terraform Basics

## Terraform Registry

TTerraform sources their providers and modules form the Terraform registry which is loacated at registry [terrafrom.io](https://registry.terraform.io)

- **Providers** are interfaces to API's that allow you to create resources in terraform
- **Modules** are a way to make large amount of terraform code modular, portable and sharable.


[Random Terraform Provider](https://registry.terraform.io/providers/hashicorp/random)

#### Terraform console

We can see the list of all terraform commands by typing `terraform`

##### Terraform init

At the start of a new terraform project we will run `terraform init` to initialize the backend, download and install providers plugins we will use in this project.

#### Terraform Plan

This will generate a change set about our infrastructure and what will be changed.

We can out put this changeset ie. `plan` to be passed to an apply, but often you can just ignore outputing.

#### Terraform Apply 

`terraform apply`

This will run a plan and pass the changeset to be executed by terraform. Apply should prompt us yes or no.

If we want to automatically apply we can provide the auto approve flag eg. `terraform apply -auto-approve`

#### Issues
Ran into an error while creating an S3 bucket rffred to the documentation and find out that your s3 bucket name must only contain lowercaseses and must not begin nor end with a letter
[S3 Naming Rules](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html)

#### Terraform Destroy
This will destroy resources .
You can also use the auto approve plan lag to skip the approve prompt
eg. `terraform destroy --auto-aprove`

#### Terraform Lock files
`.terraform.lock.hcl` contains the locked versions for the providers or modules that should be used wit this project.

The terraform lock file **should be committed** to your version control system (VCS) eg. GitHub

#### Terraform State file

`.terraform.tfstate` contains information about the current state of your infrastructure. this file **should NOT be committed** to your version control system.

This file can contain sensitive data 

If you lose this file you lose knowing th =e state of your infrastructure

`.terraform.tfstate.backup` id the previous state file.

#### Directory
`.terraform` dirctory cntains a local cache where Terraform retains some files it will need for subsequent operations against this configuration. 

## Issues with Terraform Cloud Login and Gitpod Workspace

When attempting to run `terraform login` it will launch in bash a wiswig view to generate a token. However it does not work as epected in in Gitpod VsCode in the browser.

The workaround is manually generated a tokent in Terraform Cloud


```
https://app.terraform.io/app/settings/tokens
```

Then  manually create and open the file here:

```sh
touch /home/gitpod/.terraform.d/credentials.tfrc.json
open /home/gitpod/.terraform.d/credentials.tfrc.json
```

Provide the following code (replace your token in the file)


```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "YOUR-TERRAFORM-CLOUD-TOKEN"
    }
  }
}
```

Then open the file

We have automated this workaround with the following bash script [bin/generaate_tfrc_credentials] 




