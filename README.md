# Terragrunt Bug #3428 Demo Repo

https://github.com/gruntwork-io/terragrunt/issues/3428

## Repo Layout

```
tree .
.
├── README.md
├── bad
│   ├── bbb
│   │   └── ccc
│   │       ├── module-b
│   │       │   └── terragrunt.hcl
│   │       └── workspace
│   │           └── terragrunt.hcl
│   └── good
├── good
│   ├── bbb
│   │   └── ccc
│   │       ├── _workspace
│   │       │   └── terragrunt.hcl
│   │       └── module-b
│   │           └── terragrunt.hcl
│   └── good
└── tf
    └── main.tf
```

## Bad Behaviour

Note: Group 1 module name is bad

```
terragrunt --version
terragrunt version v0.67.5
terragrunt run-all init --terragrunt-non-interactive --terragrunt-working-dir ./bad

17:45:16.530 INFO   The stack at ./bad will be processed in the following order for command init:
Group 1
- Module ./bbb/ccc../../..

Group 2
- Module ./bbb/ccc/module-b


17:45:16.567 INFO   [bbb/ccc../../..] Downloading Terraform configurations from file://.. into ./bbb/ccc../../../.terragrunt-cache/l4PGZw4kly8AGCvZSs9ROtnEsmo/GfC1_MefJlkYgRG0cg9hhw7kHhQ
17:45:16.612 STDOUT [bbb/ccc../../..] terraform: Initializing the backend...
17:45:16.623 STDOUT [bbb/ccc../../..] terraform: Initializing provider plugins...
17:45:16.623 STDOUT [bbb/ccc../../..] terraform: - Reusing previous version of hashicorp/null from the dependency lock file
17:45:16.764 STDOUT [bbb/ccc../../..] terraform: - Using previously-installed hashicorp/null v3.2.3
17:45:16.764 STDOUT [bbb/ccc../../..] terraform: Terraform has been successfully initialized!
17:45:16.764 STDOUT [bbb/ccc../../..] terraform:
17:45:16.764 STDOUT [bbb/ccc../../..] terraform: You may now begin working with Terraform. Try running "terraform plan" to see
17:45:16.764 STDOUT [bbb/ccc../../..] terraform: any changes that are required for your infrastructure. All Terraform commands
17:45:16.764 STDOUT [bbb/ccc../../..] terraform: should now work.
17:45:16.764 STDOUT [bbb/ccc../../..] terraform: If you ever set or change modules or backend configuration for Terraform,
17:45:16.764 STDOUT [bbb/ccc../../..] terraform: rerun this command to reinitialize your working directory. If you forget, other
17:45:16.764 STDOUT [bbb/ccc../../..] terraform: commands will detect it and remind you to do so if necessary.
17:45:16.813 INFO   [bbb/ccc/module-b] Downloading Terraform configurations from file://.. into ./bbb/ccc/module-b/.terragrunt-cache/qYNt7zYTLiQXrJI8mTg-2UPH3L0/GfC1_MefJlkYgRG0cg9hhw7kHhQ
17:45:16.854 STDOUT [bbb/ccc/module-b] terraform: Initializing the backend...
17:45:16.866 STDOUT [bbb/ccc/module-b] terraform: Initializing provider plugins...
17:45:16.866 STDOUT [bbb/ccc/module-b] terraform: - Reusing previous version of hashicorp/null from the dependency lock file
17:45:17.012 STDOUT [bbb/ccc/module-b] terraform: - Using previously-installed hashicorp/null v3.2.3
17:45:17.012 STDOUT [bbb/ccc/module-b] terraform: Terraform has been successfully initialized!
17:45:17.012 STDOUT [bbb/ccc/module-b] terraform:
17:45:17.012 STDOUT [bbb/ccc/module-b] terraform: You may now begin working with Terraform. Try running "terraform plan" to see
17:45:17.012 STDOUT [bbb/ccc/module-b] terraform: any changes that are required for your infrastructure. All Terraform commands
17:45:17.012 STDOUT [bbb/ccc/module-b] terraform: should now work.
17:45:17.012 STDOUT [bbb/ccc/module-b] terraform: If you ever set or change modules or backend configuration for Terraform,
17:45:17.012 STDOUT [bbb/ccc/module-b] terraform: rerun this command to reinitialize your working directory. If you forget, other
17:45:17.012 STDOUT [bbb/ccc/module-b] terraform: commands will detect it and remind you to do so if necessary.
|17:45|path:/workspace/calypso/env-def-test|aws:|git:main|?:0|
```

## Good Behaviour - Only difference is name of module `workspace` has been renamed `_workspace`!

```
terragrunt --version
terragrunt version v0.67.5
terragrunt run-all init --terragrunt-non-interactive --terragrunt-working-dir ./good
17:47:04.732 INFO   The stack at ./good will be processed in the following order for command init:
Group 1
- Module ./bbb/ccc/_workspace

Group 2
- Module ./bbb/ccc/module-b


17:47:04.769 INFO   [bbb/ccc/_workspace] Downloading Terraform configurations from file://.. into ./bbb/ccc/_workspace/.terragrunt-cache/Ce-jn7aJlp7EfpdkJanK8bgCzXA/GfC1_MefJlkYgRG0cg9hhw7kHhQ
17:47:04.813 STDOUT [bbb/ccc/_workspace] terraform: Initializing the backend...
17:47:04.825 STDOUT [bbb/ccc/_workspace] terraform: Initializing provider plugins...
17:47:04.825 STDOUT [bbb/ccc/_workspace] terraform: - Reusing previous version of hashicorp/null from the dependency lock file
17:47:04.981 STDOUT [bbb/ccc/_workspace] terraform: - Using previously-installed hashicorp/null v3.2.3
17:47:04.981 STDOUT [bbb/ccc/_workspace] terraform: Terraform has been successfully initialized!
17:47:04.981 STDOUT [bbb/ccc/_workspace] terraform:
17:47:04.981 STDOUT [bbb/ccc/_workspace] terraform: You may now begin working with Terraform. Try running "terraform plan" to see
17:47:04.981 STDOUT [bbb/ccc/_workspace] terraform: any changes that are required for your infrastructure. All Terraform commands
17:47:04.981 STDOUT [bbb/ccc/_workspace] terraform: should now work.
17:47:04.981 STDOUT [bbb/ccc/_workspace] terraform: If you ever set or change modules or backend configuration for Terraform,
17:47:04.981 STDOUT [bbb/ccc/_workspace] terraform: rerun this command to reinitialize your working directory. If you forget, other
17:47:04.981 STDOUT [bbb/ccc/_workspace] terraform: commands will detect it and remind you to do so if necessary.
17:47:05.025 INFO   [bbb/ccc/module-b] Downloading Terraform configurations from file://.. into ./bbb/ccc/module-b/.terragrunt-cache/QH_5MMe28hcPsrOdWjfBOt19g7I/GfC1_MefJlkYgRG0cg9hhw7kHhQ
17:47:05.070 STDOUT [bbb/ccc/module-b] terraform: Initializing the backend...
17:47:05.081 STDOUT [bbb/ccc/module-b] terraform: Initializing provider plugins...
17:47:05.081 STDOUT [bbb/ccc/module-b] terraform: - Reusing previous version of hashicorp/null from the dependency lock file
17:47:05.207 STDOUT [bbb/ccc/module-b] terraform: - Using previously-installed hashicorp/null v3.2.3
17:47:05.207 STDOUT [bbb/ccc/module-b] terraform: Terraform has been successfully initialized!
17:47:05.207 STDOUT [bbb/ccc/module-b] terraform:
17:47:05.207 STDOUT [bbb/ccc/module-b] terraform: You may now begin working with Terraform. Try running "terraform plan" to see
17:47:05.208 STDOUT [bbb/ccc/module-b] terraform: any changes that are required for your infrastructure. All Terraform commands
17:47:05.208 STDOUT [bbb/ccc/module-b] terraform: should now work.
17:47:05.208 STDOUT [bbb/ccc/module-b] terraform: If you ever set or change modules or backend configuration for Terraform,
17:47:05.208 STDOUT [bbb/ccc/module-b] terraform: rerun this command to reinitialize your working directory. If you forget, other
17:47:05.208 STDOUT [bbb/ccc/module-b] terraform: commands will detect it and remind you to do so if necessary.
```

## Good behaviour with previous Terragrunt version on bad path

```
terragrunt --version
terragrunt version v0.67.4
|17:50|path:/workspace/calypso/env-def-test|aws:|git:main|?:0|
$ terragrunt run-all init --terragrunt-non-interactive --terragrunt-working-dir ./bad
17:51:02.091 INFO   The stack at ./bad will be processed in the following order for command init:
Group 1
- Module bbb/ccc/workspace

Group 2
- Module bbb/ccc/module-b


17:51:02.130 INFO   [bbb/ccc/workspace] Downloading Terraform configurations from file:///workspace/calypso/env-def-test into /workspace/calypso/env-def-test/bad/bbb/ccc/workspace/.terragrunt-cache/l4PGZw4kly8AGCvZSs9ROtnEsmo/GfC1_MefJlkYgRG0cg9hhw7kHhQ
17:51:02.174 STDOUT [bbb/ccc/workspace] terraform: Initializing the backend...
17:51:02.186 STDOUT [bbb/ccc/workspace] terraform: Initializing provider plugins...
17:51:02.186 STDOUT [bbb/ccc/workspace] terraform: - Reusing previous version of hashicorp/null from the dependency lock file
17:51:02.334 STDOUT [bbb/ccc/workspace] terraform: - Using previously-installed hashicorp/null v3.2.3
17:51:02.334 STDOUT [bbb/ccc/workspace] terraform: Terraform has been successfully initialized!
17:51:02.334 STDOUT [bbb/ccc/workspace] terraform:
17:51:02.334 STDOUT [bbb/ccc/workspace] terraform: You may now begin working with Terraform. Try running "terraform plan" to see
17:51:02.334 STDOUT [bbb/ccc/workspace] terraform: any changes that are required for your infrastructure. All Terraform commands
17:51:02.334 STDOUT [bbb/ccc/workspace] terraform: should now work.
17:51:02.334 STDOUT [bbb/ccc/workspace] terraform: If you ever set or change modules or backend configuration for Terraform,
17:51:02.334 STDOUT [bbb/ccc/workspace] terraform: rerun this command to reinitialize your working directory. If you forget, other
17:51:02.334 STDOUT [bbb/ccc/workspace] terraform: commands will detect it and remind you to do so if necessary.
17:51:02.377 INFO   [bbb/ccc/module-b] Downloading Terraform configurations from file:///workspace/calypso/env-def-test into /workspace/calypso/env-def-test/bad/bbb/ccc/module-b/.terragrunt-cache/qYNt7zYTLiQXrJI8mTg-2UPH3L0/GfC1_MefJlkYgRG0cg9hhw7kHhQ
17:51:02.420 STDOUT [bbb/ccc/module-b] terraform: Initializing the backend...
17:51:02.432 STDOUT [bbb/ccc/module-b] terraform: Initializing provider plugins...
17:51:02.432 STDOUT [bbb/ccc/module-b] terraform: - Reusing previous version of hashicorp/null from the dependency lock file
17:51:02.592 STDOUT [bbb/ccc/module-b] terraform: - Using previously-installed hashicorp/null v3.2.3
17:51:02.592 STDOUT [bbb/ccc/module-b] terraform: Terraform has been successfully initialized!
17:51:02.592 STDOUT [bbb/ccc/module-b] terraform:
17:51:02.592 STDOUT [bbb/ccc/module-b] terraform: You may now begin working with Terraform. Try running "terraform plan" to see
17:51:02.592 STDOUT [bbb/ccc/module-b] terraform: any changes that are required for your infrastructure. All Terraform commands
17:51:02.592 STDOUT [bbb/ccc/module-b] terraform: should now work.
17:51:02.592 STDOUT [bbb/ccc/module-b] terraform: If you ever set or change modules or backend configuration for Terraform,
17:51:02.592 STDOUT [bbb/ccc/module-b] terraform: rerun this command to reinitialize your working directory. If you forget, other
17:51:02.592 STDOUT [bbb/ccc/module-b] terraform: commands will detect it and remind you to do so if necessary.
```
