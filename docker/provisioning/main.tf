provider "kafka" {
  bootstrap_servers = ["broker:29092"]

  ca_cert     = file("/usr/secrets/snakeoil-ca-1.crt")
  client_cert = file("/usr/secrets/kafkacat-ca1-signed.pem")
  client_key  = file("/usr/secrets/kafkacat-raw-private-key.pem")
  tls_enabled = true
  skip_tls_verify = true
}

resource "kafka_topic" "syslog" {
  name               = "syslog"
  replication_factor = 1
  partitions         = 4

  config = {
    "segment.ms"   = "4000"
    "retention.ms" = "86400000"
  }
}
