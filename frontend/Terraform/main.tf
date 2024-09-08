provider "google" {
  project     = "quickconvert"
  region      = "us-central1"
  zone        = "us-central1-a"
  credentials = file("/Users/JXR6N4L/Documents/Code/keys/quickconvert-d66904306ecd.json")
}

data "google_client_config" "default" {}

resource "google_container_cluster" "primary" {
  name               = "quickconvert-cluster"
  location           = "us-central1-a"
  initial_node_count = 1   # Minimum node count to create the cluster
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

# Null resource to delay the provider initialization
resource "null_resource" "wait_for_cluster" {
  provisioner "local-exec" {
    command = "sleep 120" # Adjust sleep time if needed for cluster creation
  }

  depends_on = [google_container_cluster.primary]
}

provider "kubernetes" {
  host                   = "https://${google_container_cluster.primary.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
  #depends_on = [null_resource.wait_for_cluster] # Wait for cluster
}


resource "kubernetes_deployment" "angular_app" {
  depends_on = [google_container_cluster.primary]
  metadata {
    name      = "quickconvert-angular-app"
    namespace = "default"
    labels = {
      app = "quickconvert-angular-app"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "quickconvert-angular-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "quickconvert-angular-app"
        }
      }

      spec {
        container {
          name  = "quickconvert-angular-app"
          image = "jxr6n4l/quickconvert-angular-app:latest"

          resources {
            limits = {
              memory = "512Mi"
              cpu    = "500m"
            }
            requests = {
              memory = "512Mi"
              cpu    = "500m"
            }
          }


          port {
            container_port = 80
          }
        }
      }
    }
  }
  # Ensure the deployment waits for the GKE cluster creation
  #depends_on = [google_container_cluster.primary]
}

resource "kubernetes_service" "angular_service" {
  metadata {
    name      = "quickconvert-angular-service"
    namespace = "default"
  }

  spec {
    selector = {
      app = "quickconvert-angular-app"
    }

    port {
      protocol    = "TCP"
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
    #load_balancer_ip = "35.208.74.101"
  }

}
