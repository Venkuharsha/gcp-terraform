resource "google_storage_bucket" "cf_bucket" {
  name                        = var.bucket_name
  location                    = var.region
  project                     = var.project_id
  uniform_bucket_level_access = true
  force_destroy               = true
}

resource "google_storage_bucket_object" "cf_zip" {
  name   = "code/docai-mi-pip-coverage-other.zip"
  bucket = google_storage_bucket.cf_bucket.name
  source = "${path.module}/docai-mi-pip-coverage-other.zip"
}