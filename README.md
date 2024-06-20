
---

# Environment-display

This project demonstrates two environments: Develop and Testing.

## Workflows Overview

To view the available workflows, navigate to the **Actions** tab. Below are the workflows available and their execution order:

1. **terraform-s3**
   - **Manual Execution:** This workflow sets up S3 and DynamoDB tables for Terraform states.
   - [Read more](docs/Terraform_S3_Workflow.md)

2. **Terraform Infra**
   - **Manual Execution:** This workflow provisions the necessary infrastructure for the project.
   - [Read more](docs/terraform_infra_Workflow.md)

3. **ci&cd Develop**
   - **Trigger:** Executes automatically on changes to the Develop branch.
   - [Read more](docs/CI&CD_Develop.md)

4. **ci&cd Testing**
   - **Trigger:** Executes automatically on changes to the Testing branch.
   - [Read more](docs/CI&CD_Testing.md)

5. **Get ECS IP Develop**
   - **Manual Execution:** This workflow get the public ip from Develop ECS.

6. **Get ECS IP Testing**
   - **Manual Execution:** This workflow get the public ip from Testing ECS .

---