variable "project_id" {
  description = "The ID of the Google Cloud project"
  type        = string
  default     = "{YOUR GCP PROJECT-ID}"
}

variable "region" {
  description = "The region to deploy resources to"
  type        = string
  default     = "asia-south1"
}

variable "db_tier" {
  description = "The tier for the database instance"
  type        = string
  default     = "db-f1-micro"
}

variable "image" {
  description = "The Docker image to deploy to Cloud Run"
  type        = string
  default     = "mustafakhn/weather-app:latest"
}
