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