provider "kafka" {
  bootstrap_servers = ["${var.kafka_url}"]

  ca_cert     = file("${var.ca_cert}")
  client_cert = file("${var.client_cert}")
  client_key  = file("${var.client_key}")
  tls_enabled = true
  skip_tls_verify = true
}

provider "kafka-connect" {
  url = "http://${var.kafka_connect_url}"
}

//provider "ksql" {
//
//}

resource "kafka_topic" "syslog" {
  provider           = kafka
  name               = "syslog"
  replication_factor = 1
  partitions         = 4

  config = {
    "segment.ms"   = "4000"
    "retention.ms" = "86400000"
  }
}

resource "kafka-connect_connector" "jdbc-summary-sink" {
  provider                                = kafka-connect
  name                                    = "jdbc-summary-sink"
  config                                  = {
    "name"                                = "jdbc-summary-sink"
    "connector.class"                     = "io.confluent.connect.jdbc.JdbcSinkConnector",
    "connection.url"                      = "jdbc:postgresql://postgres:5432/kappademo?user=postgres&password=postgres",
    "auto.create"                         = true,
    "auto.evolve"                         = true,

    "insert.mode"                         = "upsert",
    "mode"                                = "incrementing",
    "table.name.format"                   = "summary",
    "topics"                              = "summary",
    "numeric.mapping"                     = "best_fit",

    "key.converter"                       = "org.apache.kafka.connect.storage.StringConverter",
    "key.converter.schemas.enable"        = "false",

    "value.converter"                     = "io.confluent.connect.avro.AvroConverter",
    "value.converter.schemas.enable"      = "true",
    "value.converter.schema.registry.url" = "http://schema-registry:8081",

    "pk.mode"                             = "record_value",
    "pk.fields"                           = "MERCHANT_ID,PAYMENT_SCHEME",

    "dialect.name"                        = "PostgreSqlDatabaseDialect"
  }

//  config_sensitive = {
//  "connection.password" = "this-should-never-appear-unmasked"
//  }

}

output "kafka_url" {
  value = "${var.kafka_url}"
}

output "kafka_connect_url" {
  value = "${var.kafka_connect_url}"
}
