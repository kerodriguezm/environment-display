
---

This repository includes a CI/CD workflow for automating the deployment of an application on the `develop` branch using GitHub Actions and Terraform.

### Workflow File

The workflow configuration file is located at `.github/workflows/ci-cd-develop.yml`. Below are the steps executed in this workflow:

1. **Checkout code**:
   - Uses `actions/checkout@v2` to checkout the repository source code, allowing subsequent steps to access project files.

2. **Set up Docker Buildx**:
   - Configures Docker Buildx using `docker/setup-buildx-action@v1`. Buildx is a Docker tool that facilitates multi-platform image creation, useful for building and deploying applications in containers.

3. **Configure AWS credentials**:
   - Configures AWS credentials using environment variables (`AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`) fetched from repository secrets. This allows Terraform and Docker to interact with AWS services. Additionally, sets the default region to `us-east-1`.

4. **Log in to Amazon ECR**:
   - Logs in to Amazon ECR using AWS credentials to access the container registry. This enables storing and retrieving Docker container images on AWS.

5. **Retrieve last build number**:
   - Uses `github.run_number` to retrieve the current run number and sets it as the build number (`BUILD_NUMBER`), which is used to tag the Docker image.

6. **Build and Push Docker image**:
   - Builds the Docker image of the project, updating configuration based on the development environment (`MY_ENV_VARIABLE`). Then, tags the image with the build number and pushes it to Amazon ECR.

7. **Update variables.tf**:
   - Updates the `variables.tf` file in the `terraform/ecs-Develop` directory to use the newly tagged Docker image with the build number.

8. **Create infra**:
   - Initializes Terraform in the `terraform/ecs-Develop` directory to prepare the infrastructure defined in code.

9. **Plan Terraform deployment**:
   - Generates a Terraform deployment plan in the `terraform/ecs-Develop` directory to review proposed changes before applying them.

10. **Apply Terraform changes**:
    - Applies changes defined in Terraform configuration files in the `terraform/ecs-Develop` directory after reviewing and confirming the plan.

11. **Clean up Terraform plan file**:
    - Removes the Terraform plan file (`tfplan`) to maintain a clean working directory and ensure Terraform plans are not inadvertently reused.

---