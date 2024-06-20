
---

This automated workflow uses GitHub Actions to deploy and manage an S3 bucket on AWS using Terraform.

### Step 1: Checkout Source Code

The `actions/checkout@v2` action is used to checkout the repository source code, allowing subsequent steps to access project files.

```yaml
- name: Checkout code
  uses: actions/checkout@v2
```

### Step 2: Set up Docker Buildx

Docker Buildx is configured using the `docker/setup-buildx-action@v1` action. Buildx is a Docker tool that facilitates multi-platform image creation, useful for building and deploying applications in containers.

```yaml
- name: Set up Docker Buildx
  uses: docker/setup-buildx-action@v1
```

### Step 3: Configure AWS Credentials

AWS credentials are configured using environment variables (`AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`) fetched from repository secrets. This allows Terraform to interact with AWS services. Additionally, the AWS region is set to `us-east-1`.

```yaml
- name: Configure AWS credentials
  env:
    AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
    AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
  run: |
    aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
    aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
    aws configure set default.region us-east-1
```

### Step 4: Initialize Terraform

In the `terraform/s3-state` directory, `terraform init` is executed to initialize Terraform. This step downloads necessary modules and plugins required to execute Terraform scripts.

```yaml
- name: Create S3
  working-directory: terraform/s3-state
  run: |
    terraform init
```

### Step 5: Terraform Plan Creation

In the same directory (`terraform/s3-state`), a Terraform deployment plan is created using `terraform plan -out=tfplan`. The generated plan (`tfplan`) allows reviewing proposed changes before applying them.

```yaml
- name: Plan Terraform deployment
  working-directory: terraform/s3-state
  run: terraform plan -out=tfplan
```

### Step 6: Apply Terraform Changes

Once the plan is reviewed and changes are confirmed, `terraform apply -auto-approve tfplan` is executed to apply modifications defined in Terraform configuration files.

```yaml
- name: Apply Terraform changes
  working-directory: terraform/s3-state
  run: terraform apply -auto-approve tfplan
```

### Step 7: Clean Up Terraform Plan

Finally, the Terraform plan file (`tfplan`) is cleaned up using `rm -rf tfplan`. This action helps maintain a clean working directory and ensures Terraform plans are not inadvertently reused.

```yaml
- name: Clean up Terraform plan file
  working-directory: terraform/s3-state
  run: rm -rf tfplan
```

---
