resource "google_service_account" "default" {
  account_id   = "jenkinsviaansible"
  display_name = "Service Account"
}

resource "google_compute_instance" "default" {
  name         = "GCPChallenge"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-8" #"debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "jenkins"

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}
resource "google_compute_firewall" "default" {
  name    = "jenkins"
  network = google_compute_network.default.name

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  source_tags = ["web"]
}
resource "google_compute_network" "default" {
  name = "jenkins"
}

data "google_service_account" "jenkinsviaansible" {
  account_id = "myaccount-id"
}

resource "google_service_account_key" "mykey" {
  service_account_id = data.google_service_account.jenkinsviaansible.name
}
data "google_service_account_key" "mykey" {
  name            = google_service_account_key.mykey.name
  public_key_type = "TYPE_X509_PEM_FILE"
}
