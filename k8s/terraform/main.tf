module "prepare" {
  source            = "./modules/prepare"
  monitoring_namespace = var.monitoring_namespace
  kafka_namespace      = var.kafka_namespace
  database_namespace   = var.database_namespace
}

module "prometheus" {
  source            = "./modules/prometheus"
  prometheus_host   = var.prometheus_host
  prometheus_config = var.prometheus_config
  namespace = var.monitoring_namespace
  depends_on = [module.prepare]
}

module "grafana" {
  source                = "./modules/grafana"
  grafana_host          = var.grafana_host
  grafana_admin_password = var.grafana_admin_password
  namespace = var.monitoring_namespace
  depends_on = [module.prepare]
}

module "jaeger" {
  source                        = "./modules/jaeger"
  jaeger_host                   = var.jaeger_host
  jaeger_collector_zipkin_http_port = var.jaeger_collector_zipkin_http_port
  jaeger_query_base_path        = var.jaeger_query_base_path
  namespace = var.monitoring_namespace
  depends_on = [module.prepare]
}

module "kafka" {
  source                = "./modules/kafka"
  kafka_host            = var.kafka_host
  namespace = var.kafka_namespace
  depends_on = [module.prepare]
}

# module "postgresql" {
#   source            = "./modules/postgresql"
#   postgres_host     = var.postgres_host
#   postgres_password = var.postgres_password
#   postgres_user     = var.postgres_user
#   postgres_db       = var.postgres_db
#   namespace = var.database_namespace
#   depends_on = [module.prepare]
# }





# module "graylog" {
#   source                  = "./modules/graylog"
#   graylog_host            = var.graylog_host
#   graylog_password_secret = var.graylog_password_secret
#   graylog_root_password_sha2 = var.graylog_root_password_sha2
#   namespace = var.monitoring_namespace
# }
