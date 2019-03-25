resource "null_resource" "arangodb-setup" {
  depends_on = ["oci_core_instance.ArangoDB"]

  provisioner "file" {
    source      = "scripts/remote-exec.sh"
    destination = "/home/opc/remote-exec.sh"

    connection {
      agent       = false
      timeout     = "10m"
      host        = "${data.oci_core_vnic.arangodb_vnic.public_ip_address}"
      user        = "opc"
      private_key = "${file(var.private_key_path)}"
    }
  }

  provisioner "remote-exec" {
    connection {
      agent       = false
      timeout     = "10m"
      host        = "${data.oci_core_vnic.arangodb_vnic.public_ip_address}"
      user        = "opc"
      private_key = "${file(var.private_key_path)}"
    }

    inline = [
      "chmod +x /home/opc/remote-exec.sh",
      "sudo -i /home/opc/remote-exec.sh",
    ]
  }
}