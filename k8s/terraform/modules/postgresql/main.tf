resource "kubernetes_deployment" "postgresql" {
  metadata {
    name      = var.name
    namespace = var.namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "postgresql"
      }
    }

    template {
      metadata {
        labels = {
          app = "postgresql"
        }
      }

      spec {
        container {
          name  = "postgresql"
          image = "postgres:latest"

          resources {
            requests = {
              cpu    = "100m"
              memory = "200Mi"
            }
            limits = {
              cpu    = "200m"
              memory = "400Mi"
            }
          }

          liveness_probe {
            exec {
              command = ["pg_isready"]
            }
            initial_delay_seconds = 30
            period_seconds        = 10
          }

          readiness_probe {
            exec {
              command = ["pg_isready"]
            }
            initial_delay_seconds = 30
            period_seconds        = 10
          }

          startup_probe {
            exec {
              command = ["pg_isready"]
            }
            initial_delay_seconds = 30
            period_seconds        = 10
          }

          env {
            name  = "POSTGRES_DB"
            value = var.postgres_db
          }

          env {
            name  = "POSTGRES_USER"
            value = var.postgres_user
          }

          env {
            name  = "POSTGRES_PASSWORD"
            value = var.postgres_password
          }

          volume_mount {
            name      = "postgresql-persistent-storage"
            mount_path = "/var/lib/postgresql/data"
          }
        }

        volume {
          name = "postgresql-persistent-storage"

          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.postgresql.metadata[0].name
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "postgresql" {
  metadata {
    name      = var.name
    namespace = var.namespace
  }

  spec {
    selector = {
      app = "postgresql"
    }

    port {
      port        = 5432
      target_port = 5432
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_persistent_volume" "postgresql" {
  metadata {
    name = "postgresql-pv"
  }

  spec {
    capacity = {
      storage = "4Gi"
    }

    access_modes = ["ReadWriteOnce"]

    persistent_volume_reclaim_policy = "Retain"

    storage_class_name = "local-path"

    persistent_volume_source {
      host_path {
        path = "/mnt/data"
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "postgresql" {
  metadata {
    name      = var.name
    namespace = var.namespace
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    resources {
      requests = {
        storage = "4Gi"
      }
    }

    storage_class_name = "local-path"
  }
}

resource "kubernetes_horizontal_pod_autoscaler" "postgresql" {
  metadata {
    name      = var.name
    namespace = var.namespace
  }

  spec {
    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = kubernetes_deployment.postgresql.metadata[0].name
    }

    min_replicas                    = 1
    max_replicas                    = 10
    target_cpu_utilization_percentage = 60
  }
}