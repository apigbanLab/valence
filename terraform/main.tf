module "vcn" {
  source  = "oracle-terraform-modules/vcn/oci"
  version = "v3.5.3"

  # general oci parameters
  compartment_id = var.provider_compartment_id
  label_prefix   = var.provider_label_prefix

  # vcn parameters
  create_internet_gateway  = var.create_internet_gateway
  create_nat_gateway       = var.create_nat_gateway
  create_service_gateway   = var.create_service_gateway
  vcn_cidrs                = var.vcn_cidrs
  vcn_dns_label            = var.vcn_dns_label
  vcn_name                 = var.vcn_name
  lockdown_default_seclist = var.lockdown_default_seclist
  attached_drg_id          = var.attached_drg_id
}


resource "oci_core_subnet" "subnet_k3s-agent" {
  #Required
  cidr_block     = var.subnet_k3s-agent_cidr_block
  compartment_id = var.provider_compartment_id
  vcn_id         = module.vcn.vcn_id

  #Optional
  display_name               = var.subnet_k3s-agent_dns_label
  dns_label                  = var.subnet_k3s-agent_dns_label
  prohibit_public_ip_on_vnic = var.subnet_k3s-agent_prohibit_public_ip_on_vnic
  route_table_id             = module.vcn.ig_route_id
}

resource "oci_core_subnet" "subnet_k3s-server" {
  #Required
  cidr_block     = var.subnet_k3s-server_cidr_block
  compartment_id = var.provider_compartment_id
  vcn_id         = module.vcn.vcn_id

  #Optional
  display_name               = var.subnet_k3s-server_dns_label
  dns_label                  = var.subnet_k3s-server_dns_label
  prohibit_public_ip_on_vnic = var.subnet_k3s-server_prohibit_public_ip_on_vnic
  route_table_id             = module.vcn.ig_route_id
}

resource "oci_core_subnet" "subnet_k3s-db" {
  #Required
  cidr_block     = var.subnet_k3s-db_cidr_block
  compartment_id = var.provider_compartment_id
  vcn_id         = module.vcn.vcn_id

  #Optional
  display_name               = var.subnet_k3s-db_dns_label
  dns_label                  = var.subnet_k3s-db_dns_label
  prohibit_public_ip_on_vnic = var.subnet_k3s-db_prohibit_public_ip_on_vnic
  route_table_id             = module.vcn.ig_route_id
}

resource "oci_core_internet_gateway" "igw" {
  #Required
  compartment_id = var.provider_compartment_id
  vcn_id         = module.vcn.vcn_id

  #Optional
  display_name = var.internet_gateway_display_name
}

resource "oci_core_default_route_table" "this" {
  manage_default_resource_id = oci_core_subnet.subnet_k3s-agent.route_table_id
  route_rules {
    #Required
    network_entity_id = oci_core_internet_gateway.igw.id
    destination       = "0.0.0.0/0"
  }
}