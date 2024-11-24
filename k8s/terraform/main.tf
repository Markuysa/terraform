module "grafana" {
  source                = "./modules/grafana"
  grafana_host          = var.grafana_host
  grafana_admin_password = var.grafana_admin_password
}

module "graylog" {
  source                  = "./modules/graylog"
  graylog_host            = var.graylog_host
  graylog_password_secret = var.graylog_password_secret
  graylog_root_password_sha2 = var.graylog_root_password_sha2
}

module "jaeger" {
  source                        = "./modules/jaeger"
  jaeger_host                   = var.jaeger_host
  jaeger_collector_zipkin_http_port = var.jaeger_collector_zipkin_http_port
  jaeger_query_base_path        = var.jaeger_query_base_path
}

module "kafka" {
  source                = "./modules/kafka"
  kafka_host            = var.kafka_host
}

module "postgresql" {
  source            = "./modules/postgresql"
  postgres_host     = var.postgres_host
  postgres_password = var.postgres_password
  postgres_user     = var.postgres_user
  postgres_db       = var.postgres_db
}

module "prometheus" {
  source            = "./modules/prometheus"
  prometheus_host   = var.prometheus_host
  prometheus_config = var.prometheus_config
}