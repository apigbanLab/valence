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


resource "oci_core_subnet" "public_subnet" {
    #Required
    cidr_block = var.subnet_public_cidr_block
    compartment_id = var.provider_compartment_id
    vcn_id = module.vcn.vcn_id

    #Optional
    display_name = var.subnet_public_dns_label
    dns_label = var.subnet_public_dns_label
    prohibit_public_ip_on_vnic = var.subnet_public_prohibit_public_ip_on_vnic
    route_table_id = module.vcn.ig_route_id
    # security_list_ids = oci_core_vcn.oracle_one.security_list_ids


}

resource "oci_core_subnet" "private_subnet" {
    #Required
    cidr_block = var.subnet_private_cidr_block
    compartment_id = var.provider_compartment_id
    vcn_id = module.vcn.vcn_id

    #Optional
    display_name = var.subnet_private_dns_label
    dns_label = var.subnet_private_dns_label
    prohibit_public_ip_on_vnic = var.subnet_private_prohibit_public_ip_on_vnic
    route_table_id = module.vcn.ig_route_id
    # security_list_ids = oci_core_vcn.oracle_one.security_list_ids
}