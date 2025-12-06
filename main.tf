module "Cloud-functions" {
  source  = "app.terraform.io/tlz-venk/Cloud-functions/google"
  version = "0.0.2"

  project_id = var.project_id
  region     = var.region

  function_name = "docai-mi-pip-coverage-other"
  runtime       = "python312"
  entry_point   = "main"

  # GCS bucket + object created by Terraform
  source_archive_bucket = google_storage_bucket.cf_bucket.name
  source_archive_object = google_storage_bucket_object.cf_zip.name

  # Service account created by Terraform
  service_account_email = google_service_account.cf_sa.email

  # Optional settings
  ingress_settings = "ALLOW_ALL"
  environment_variables = {
    ENV = "dev"
  }

  max_instances = 100
  min_instances = 2

  # No VPC connector for now
  vpc_connector = null

  allow_unauthenticated = true

  labels = {
    app = "personal-test"
  }
}