provider "google" {
  project     = "quickconvert"
  region      = "us-central1"
  zone        = "us-central1-a"
  credentials = file("/Users/JXR6N4L/Documents/Code/keys/quickconvert-d66904306ecd.json")
}

resource "google_container_cluster" "primary" {
  name               = "quickconvert-cluster"
  location           = "us-central1-a"
  initial_node_count = 1
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "primary-node-pool"
  location   = "us-central1-a"
  cluster    = google_container_cluster.primary.name

  node_config {
    machine_type = "e2-standard-2"
    disk_size_gb = 10
    disk_type    = "pd-standard"
  }

  autoscaling {
    min_node_count = 1
    max_node_count = 5
  }

  initial_node_count = 2
}

output "cluster_endpoint" {
  value = google_container_cluster.primary.endpoint
}

# Wait for cluster to be created
resource "null_resource" "wait_for_cluster" {
  provisioner "local-exec" {
    command = "sleep 120"
  }
  depends_on = [google_container_cluster.primary]
}
