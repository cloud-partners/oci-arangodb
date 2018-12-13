resource "oci_core_virtual_network" "ArangoVCN" {
  cidr_block     = "10.1.0.0/16"
  compartment_id = "${var.compartment_ocid}"
  display_name   = "ArangoVCN"
  dns_label      = "arangovcn"
}

resource "oci_core_subnet" "ArangoSubnet" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.availability_domain - 1],"name")}"
  cidr_block          = "10.1.20.0/24"
  display_name        = "ArangoSubnet"
  dns_label           = "arangosubnet"
  security_list_ids   = ["${oci_core_security_list.ArangoSecurityList.id}"]
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.ArangoVCN.id}"
  route_table_id      = "${oci_core_route_table.ArangoRT.id}"
  dhcp_options_id     = "${oci_core_virtual_network.ArangoVCN.default_dhcp_options_id}"
}

resource "oci_core_internet_gateway" "ArangoIG" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "ArangoIG"
  vcn_id         = "${oci_core_virtual_network.ArangoVCN.id}"
}
resource "oci_core_route_table" "ArangoRT" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_virtual_network.ArangoVCN.id}"
  display_name   = "ArangoRouteTable"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = "${oci_core_internet_gateway.ArangoIG.id}"
  }
}
