# k3s-server_nsg
resource "oci_core_network_security_group" "k3s-server_nsg" {
  compartment_id = var.provider_compartment_id
  display_name   = "k3s-server-subnet-nsg"
  vcn_id         = module.vcn.vcn_id
}

# k3s-agent_nsg
resource "oci_core_network_security_group" "k3s-agent_nsg" {
  compartment_id = var.provider_compartment_id
  display_name   = "k3s-agent-subnet-nsg"
  vcn_id         = module.vcn.vcn_id
}

# k3s-db_nsg
resource "oci_core_network_security_group" "k3s-db_nsg" {
  compartment_id = var.provider_compartment_id
  display_name   = "k3s-db-subnet-nsg"
  vcn_id         = module.vcn.vcn_id
}