variable "kafka_url" {
  default = "localhost:29092"
}

variable "kafka_connect_url" {
  default = "localhost:18083"
}

variable "ca_cert" {
  default = "../../secrets/snakeoil-ca-1.crt"
}

variable "client_cert" {
  default = "../../secrets/kafkacat-ca1-signed.pem"
}

variable "client_key" {
  default = "../../secrets/kafkacat-raw-private-key.pem"
}
