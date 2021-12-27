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

# echo "Do you want to run terraform plan for backend infra? yes/no"
# read isbackendplan

isbackendplan="yes"

case "$isbackendplan" in
    "yes")
        cd $env; terraform plan --var-file="$env.tfvars" && PLANINFRA="SUCCESS"; cd ..
        if [[ $PLANINFRA != "SUCCESS" ]]; then
            echo "Backend plan failed, please review the code..."
            exit 200
        fi
        ;;
    "no")
        ;;
    *)
        echo "Invalid input"
esac

echo "continue to apply backend infra? (yes/no)"
read isbackendapply
if [[ $isbackendapply == "yes" ]]; then
    cd $env; terraform apply --var-file="$env.tfvars" -auto-approve; cd ..
else echo "Skipping apply ..."
fi

# echo "Do you want to run terraform plan for main infra? yes/no"
# read isplan

isplan="yes"

case "$isplan" in
    "yes")
        terraform plan --var-file="$env/$env.tfvars" && PLANMAIN="SUCCESS"; cd ..
        if [[ $PLANMAIN != "SUCCESS" ]]; then
            echo "Plan failed, please review the code..."
            exit 201
        fi
        ;;
    "no")
        ;;
    *)
        echo "Invalid input"
esac

echo "continue to apply main infra? (yes/no)"
read isapply
if [[ $isapply == "yes" ]]; then
    terraform apply --var-file="$env/$env.tfvars" -auto-approve
else echo "Skipping apply ..."
fi