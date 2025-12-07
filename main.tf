module "cloudfn" {
  source = "./modules/cloud-function"

  project_id = var.project_id
  region     = var.region

  function_name = "docai-mi-pip-coverage-other"
  runtime       = "python312"
  entry_point   = "main"

  source_dir = "${path.module}/src"

  bucket_name = google_storage_bucket.cf_bucket.name
  service_account_email = google_service_account.cf_sa.email

  environment_vars = {
    ENV  = "dev"
    TEST = "123"
  }

  max_instances = 100
  min_instances = 2
  timeout       = 200
  memory        = "512M"

  allow_unauthenticated = true

  labels = {
    app = "personal-test"
  }
}
