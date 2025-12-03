provider "google" {
  credentials = var.google_credentials
  project     = var.project
  region      = var.region
  zone        = var.zone
}