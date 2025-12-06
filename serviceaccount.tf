resource "google_service_account" "cf_sa" {
  account_id   = "personal-cf-sa"
  display_name = "Personal Cloud Function SA"
  project      = var.project_id
}

resource "google_project_iam_member" "cf_sa_run_invoker" {
  project = var.project_id
  role    = "roles/run.invoker"
  member  = "serviceAccount:${google_service_account.cf_sa.email}"
}

resource "google_project_iam_member" "cf_sa_cf_dev" {
  project = var.project_id
  role    = "roles/cloudfunctions.developer"
  member  = "serviceAccount:${google_service_account.cf_sa.email}"
}

resource "google_project_iam_member" "cf_sa_storage_viewer" {
  project = var.project_id
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.cf_sa.email}"
}