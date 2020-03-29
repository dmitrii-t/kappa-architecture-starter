provider "kafka" {
  bootstrap_servers = ["broker:29092"]

  ca_cert     = file("/home/tf/secrets/snakeoil-ca-1.crt")
  client_cert = file("/home/tf/secrets/kafkacat-ca1-signed.pem")
  client_key  = file("/home/tf/secrets/kafkacat-raw-private-key.pem")
  tls_enabled = true
  skip_tls_verify = true
}

provider "kafka-connect" {
  url = "http://kafka-connect-cp:18083"
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
