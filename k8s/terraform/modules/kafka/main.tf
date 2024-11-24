resource "kubernetes_deployment" "kafka" {
  metadata {
    name      = var.name
    namespace = var.namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "kafka"
      }
    }

    template {
      metadata {
        labels = {
          app = "kafka"
        }
      }

      spec {
        container {
          name  = "kafka"
          image = "bitnami/kafka:latest"

          # Specify roles: both broker and controller
          env {
            name  = "KAFKA_CFG_PROCESS_ROLES"
            value = "broker,controller"
          }

          # Unique node ID for this Kafka broker
          env {
            name  = "KAFKA_CFG_NODE_ID"
            value = "1"
          }

          # Controller quorum configuration
          env {
            name  = "KAFKA_CFG_CONTROLLER_QUORUM_VOTERS"
            value = "1@localhost:9093"
          }

          # Listener configurations
          env {
            name  = "KAFKA_CFG_LISTENER_SECURITY_PROTOCOL_MAP"
            value = "PLAINTEXT:PLAINTEXT,CONTROLLER:PLAINTEXT"
          }

          env {
            name  = "KAFKA_CFG_LISTENERS"
            value = "PLAINTEXT://:9092,CONTROLLER://:9093"
          }

          # Advertised listeners
          env {
            name  = "KAFKA_CFG_ADVERTISED_LISTENERS"
            value = "PLAINTEXT://kafka:9092"
          }

          # Define the listener name for the controller role
          env {
            name  = "KAFKA_CFG_CONTROLLER_LISTENER_NAMES"
            value = "CONTROLLER"
          }

          # Inter-broker communication listener
          env {
            name  = "KAFKA_CFG_INTER_BROKER_LISTENER_NAME"
            value = "PLAINTEXT"
          }

          # Kafka log directories
          env {
            name  = "KAFKA_LOG_DIRS"
            value = "/var/lib/kafka/data"
          }

          # KRaft cluster ID (ensure consistency for multi-node setups)
          env {
            name  = "KAFKA_KRAFT_CLUSTER_ID"
            value = "B1d9FyhPRJ-aXLZ7buvU5A" # Generated or predefined
          }

          volume_mount {
            name       = "kafka-data"
            mount_path = "/var/lib/kafka/data"
          }

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
              command = ["sh", "-c", "echo dump | nc localhost 9092"]
            }
            initial_delay_seconds = 100
            period_seconds        = 100
          }

          readiness_probe {
            exec {
              command = ["sh", "-c", "echo dump | nc localhost 9092"]
            }
            initial_delay_seconds = 100
            period_seconds        = 100
          }

          startup_probe {
            exec {
              command = ["sh", "-c", "echo dump | nc localhost 9092"]
            }
            initial_delay_seconds = 100
            period_seconds        = 100
          }
        }

        volume {
          name = "kafka-data"
          empty_dir {}
        }
      }
    }
  }
}

resource "kubernetes_service" "kafka" {
  metadata {
    name      = var.name
    namespace = var.namespace
  }

  spec {
    selector = {
      app = "kafka"
    }

    port {
      name        = "client"
      port        = 9092
      target_port = 9092
    }

    port {
      name        = "controller"
      port        = 9093
      target_port = 9093
    }

    type = "ClusterIP"
  }
}