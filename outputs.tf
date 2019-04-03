output "ArangoDB VM public IP" {
  value = "${data.oci_core_vnic.arangodb_vnic.public_ip_address}"
}

output "ArangoDB Username" {
  value = "root"
}

output "ArangoDB Password" {
  value     = "${ var.password == "" ? local.password : "Password provided as input" }"
  sensitive = false
}
