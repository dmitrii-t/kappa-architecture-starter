provider "kafka" {
  bootstrap_servers = ["localhost:9092"]

//  ca_cert     = file("../secrets/snakeoil-ca-1.crt")
//  client_cert = file("../secrets/kafkacat-ca1-signed.pem")
//  client_key  = file("../secrets/kafkacat-raw-private-key.pem")
//  tls_enabled = true
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
