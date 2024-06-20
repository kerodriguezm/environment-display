
---

This repository contains a GitHub Actions workflow for deploying and managing infrastructure (VPC) on AWS using Terraform.

### Workflow File

The workflow configuration file is located at `.github/workflows/terraform-infra.yml`. Below are the steps executed in this workflow:

1. **Checkout code**:
   - Uses `actions/checkout@v2` to checkout the repository source code, allowing subsequent steps to access project files.

2. **Set up Docker Buildx**:
   - Configures Docker Buildx using `docker/setup-buildx-action@v1`. Buildx is a Docker tool that facilitates multi-platform image creation, useful for building and deploying applications in containers.

3. **Configure AWS credentials**:
   - Configures AWS credentials using environment variables (`AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`) fetched from repository secrets. This allows Terraform to interact with AWS services. Additionally, sets the default region to `us-east-1`.

4. **Initialize Terraform**:
   - Executes `terraform init` in the `terraform/infra-vpc` directory to initialize Terraform. This downloads necessary modules and plugins required to execute Terraform scripts.

5. **Plan Terraform deployment**:
   - Generates a deployment plan using `terraform plan -out=tfplan` in the `terraform/infra-vpc` directory. The generated plan (`tfplan`) allows reviewing proposed infrastructure changes before applying them.

6. **Apply Terraform changes**:
   - Applies changes defined in Terraform configuration files using `terraform apply -auto-approve tfplan` after reviewing and confirming the plan.

7. **Clean up Terraform plan file**:
   - Removes the Terraform plan file (`tfplan`) with `rm -rf tfplan` to maintain a clean working directory and ensure Terraform plans are not inadvertently reused.

---