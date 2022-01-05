# custom-infra-aws
custom aws infra using terraform

To create a customized infrastructure using user provided number of subnets, cidr range, region etc. 

## To try with terraform locally:
* Clone this repo
* Change the backend/backend.tfvars file with the values you want.
* Initialize the backend.
```
$ cd backend
$ terraform init
```
* Apply the backend. This will create s3 bucket and dynamoDB table
```
$ cd ..
$ terraform apply -var-file=backend.tfvars
```
* Initialize main
```
$ terraform init -backend-config=access_key=<your_access_key> -backend-config=secret_key=<your_secret_key>
```

* Create workspaces for each environment
```
$ terraform workspace new dev
$ terraform workspace new prod
```

* Plan and apply main infra
```
$ terraform workspace select <your_environment..dev/prod>
$ terraform plan -var access_key=<your_access_key> -var secret_key=<your_secret_key> --var-file=<your_env>.tfvars
$ terraform apply -var access_key=<your_access_key> -var secret_key=<your_secret_key> --var-file=<your_env>.tfvars -auto-approve
```


## To try with terraform with Jenkins:

* Save your access key and secret key in Jenkins secret store with type username and password where username is access key and password is secret key. Give the credential ID the name 'tfadminuser' or any other name of your choice. Make sure you change the credetial ID in the jenkinsfiles as well.
* Create two jenkins jobs of type pipeline, one for backend and one for main infra.
* Apply the backend infra first with checkboxes "initBackend" and "applyBackedInfra"
* Once the backend infra is ready, run the other jenkins job with "env" of your choice, "initMain", and "createWS" check boxes.
* Please note that init and createWS check boxes are for the first time run for each environment. Second run onwards, both jobs can be run without any options checked.
