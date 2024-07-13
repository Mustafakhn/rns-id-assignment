provider "google" {
  project = var.project_id
  region  = var.region
}

# Database (Cloud SQL for MySQL)
resource "google_sql_database_instance" "main" {
  name             = "rns-id-assignment-db-instance"
  database_version = "MYSQL_8_0"
  region           = var.region

  settings {
    tier = var.db_tier
  }
}

resource "google_sql_database" "database" {
  name     = "rns-id-assignment-database"
  instance = google_sql_database_instance.main.name
}

# Cloud Run service
resource "google_cloud_run_service" "default" {
  name     = "rns-id-assignment-cloudrun"
  location = var.region

  template {
    spec {
      containers {
        image = var.image
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

# Load Balancer
resource "google_compute_global_address" "default" {
  name = "rns-id-assignment-lb-ip"
}

resource "google_compute_global_forwarding_rule" "default" {
  name       = "rns-id-assignment-forwarding-rule"
  target     = google_compute_target_http_proxy.default.id
  port_range = "80"
  ip_address = google_compute_global_address.default.address
}

resource "google_compute_target_http_proxy" "default" {
  name    = "rns-id-assignment-http-proxy"
  url_map = google_compute_url_map.default.id
}

resource "google_compute_url_map" "default" {
  name            = "rns-id-assignment-url-map"
  default_service = google_compute_backend_service.default.id
}

resource "google_compute_backend_service" "default" {
  name        = "rns-id-assignment-backend-service"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 10

  backend {
    group = google_compute_region_network_endpoint_group.cloudrun_neg.id
  }
}

resource "google_compute_region_network_endpoint_group" "cloudrun_neg" {
  name                  = "rns-id-assignment-cloudrun-neg"
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  cloud_run {
    service = google_cloud_run_service.default.name
  }
}
