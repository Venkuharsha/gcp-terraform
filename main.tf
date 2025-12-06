module "docai_mi_pip_coverage_other" {
  source  = "app.terraform.io/tlz-venk/Cloud-functions/google"
  version = "0.0.1"

  project_id          = var.project_id
  region              = var.region
  name                = "docai-mi-pip-coverage-other"
  bucket_name         = var.bucket_name
  source_code_from_gs = true

  source_archive_object = google_storage_bucket_object.cf_zip.name

  function_config = {
    entry_point           = "main"
    available_memory      = "4Gi"
    available_cpu         = "2000m"
    runtime               = "python312"
    timeout_seconds       = 1200
    max_instance_count    = 100
    min_instance_count    = 2
  }

  # ✅ No VPC connector for now
  vpc_connector = null

  service_account_email = google_service_account.cf_sa.email
  ingress_settings      = "ALLOW_ALL"

  docker_repository_id = "projects/${var.project_id}/locations/${var.region}/repositories/gcr-artifacts"

  iam = {
    "roles/run.invoker" = ["allUsers"]
  }

  runtime_env = {
    environment_variables = {}
  }

  bundle_config = {
    source_dir  = "./src/docai-mi-pip-coverage-other"
    output_path = null
    excludes    = []
  }
}