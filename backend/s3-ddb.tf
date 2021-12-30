provider "aws" {
    region = "${var.region}"
    access_key = var.access_key
    secret_key = var.secret_key
}

resource aws_s3_bucket "bucket" {
    bucket = "s3-backend-${var.app_name}"
    force_destroy = true
    # versioning {
    #     enabled = false
    # }
    server_side_encryption_configuration {
        rule {
            apply_server_side_encryption_by_default {
                sse_algorithm = "AES256"
            }
        }
    }
        object_lock_configuration {
            object_lock_enabled = "Enabled"
    }
    tags = {
        Name = "${var.app_name} tfstate store"
    }
}

resource aws_dynamodb_table "terraform-lock" {
    name           = "terraform_state"
    read_capacity  = 5
    write_capacity = 5
    hash_key       = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
    tags = {
        "Name" = "${var.app_name} DynamoDB Terraform State Lock Table"
    }
}
