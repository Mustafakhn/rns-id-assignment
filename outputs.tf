output "database_instance_name" {
  description = "The name of the database instance"
  value       = google_sql_database_instance.main.name
}

output "database_name" {
  description = "The name of the database"
  value       = google_sql_database.database.name
}

output "cloud_run_url" {
  description = "The URL of the deployed Cloud Run service"
  value       = google_cloud_run_service.default.status[0].url
}

output "load_balancer_ip" {
  description = "The IP address of the Load Balancer"
  value       = google_compute_global_address.default.address
}
