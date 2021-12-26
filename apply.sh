#!/bin/bash
echo "is backend initialization required? (yes/no)"
read isinit

echo "Enter the environment name (dev/stg/prod)"
read env

case "$isinit" in
    "yes")
        cd $env; terraform init; terraform apply --var-file=$env.tfvars -auto-approve; cd ..
        terraform init -backend-config=access_key="AKIAWCPECVZL7JCXM55U" \
                       -backend-config=secret_key="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"
        if [[ $? != 0 ]]; then exit 100; else continue; fi
        ;;
    "no")
        ;;
    *)
        echo "Invalid input"
esac

echo "Do you want to run terraform plan? yes/no"
read isplan

case "$isplan" in
    "yes")
        terraform plan --var-file="$env/$env.tfvars"
        if [[ $? == 0 ]]; then
            export PLAN="SUCCESS"
        else echo "plan failed, please review the code..."
        exit 200
        fi
        ;;
    "no")
        ;;
    *)
        echo "Invalid input"
esac

echo "continue to apply? (yes/no)"
read isapply
if [[ $isapply == "yes" ]]; then
    terraform apply --var-file="$env/$env.tfvars" -auto-approve
else echo "Skipping apply ..."
fi