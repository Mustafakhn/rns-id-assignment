# Weather App Terraform Deployment

This Terraform configuration deploys a weather application on Google Cloud Platform, including a Cloud SQL database, Cloud Run service, and Load Balancer.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed (v0.12+)
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) installed and configured
- A Google Cloud Platform project

## Deployment Steps

Open `variables.tf` and update the `project_id` variable with your GCP project ID:

```hcl
variable "project_id" {
  description = "The ID of the Google Cloud project"
  type        = string
  default     = "{YOUR GCP PROJECT-ID}"  # Change this line
}
```

Initialize Terraform

```terraform init```

Review the Terraform plan

```terraform plan```

This command shows you what resources will be created.

Apply the Terraform configuration

```terraform apply```

Type 'yes' when prompted to create the resources.

Access your deployment

After the deployment is complete, Terraform will output important information such as the Cloud Run URL and Load Balancer IP. You can view these again by running:

```terraform output```

Cleaning Up
To avoid incurring charges, remember to destroy the resources when you're done:

```terraform destroy```

Type 'yes' when prompted to destroy the resources.

Customization

You can customize the deployment by modifying the variables in variables.tf. Key variables include:

- region: The GCP region for resource deployment
- db_tier: The tier for the Cloud SQL instance
- image: The Docker image for the Cloud Run service

Troubleshooting
If you encounter any issues during deployment, ensure that:

1. You have the necessary permissions in your GCP project
2. The required APIs are enabled (Cloud Run, Cloud SQL, Compute Engine)
3. Your GCP credentials are correctly set up
