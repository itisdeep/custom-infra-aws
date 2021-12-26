#!/bin/bash
echo "confirm destroy infra? (yes/no)"
read isdestroyinfra

echo "Enter the environment name (dev/stg/prod)"
read env

case "$isdestroyinfra" in
    "yes")
        terraform apply --var-file="$env/$env.tfvars" -auto-approve
        if [[ $? != 0 ]]; then exit 100; else continue; fi
        ;;
    "no")
        exit 0
        ;;
    *)
        echo "Invalid input"
esac

echo "Do you want to destroy backend as well? yes/no"
read isdestroybackend

case "$isdestroybackend" in
    "yes")
        cd $env; terraform destroy --var-file=$env.tfvars -auto-approve; cd ..
        if [[ $? != 0 ]]; then exit 200; else continue; fi
        ;;
    "no")
        ;;
    *)
        echo "Invalid input"
esac