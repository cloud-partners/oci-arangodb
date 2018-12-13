output "ArangoDB VM public ip" {
  value = ["${oci_core_instance.ArangoDB.*.public_ip}"]
}