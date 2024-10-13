resource "google_compute_subnetwork" "vpc-network" {
  name          = "vpc-subnetwork"
  ip_cidr_range = "172.30.2.0/24"
  region        = "europe-north1"
  network       = google_compute_network.custom-test.id
  }

resource "google_compute_network" "vpc-network" {
  name                    = "vpc-network"
  auto_create_subnetworks = false
}


data "google_compute_image" "ubuntu" {
  most_recent = true
  project     = "ubuntu-os-cloud" 
  family      = "ubuntu-2204-lts"
}



resource "google_compute_instance" "gcp-client-vm" {
  name         = "gcp-client-vm"
  machine_type = "e2-standard-2"
  
  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu.self_link
    }
  }
  network_interface {
   subnetwork = "vpc-subnetwork"
   access_config {
      # Leave empty for dynamic public IP
    }
  }  

}