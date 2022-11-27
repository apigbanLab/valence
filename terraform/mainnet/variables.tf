# Copyright (c) 2019, 2021, Oracle Corporation and/or affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

# provider identity parameters
# general oci parameters

variable "provider_compartment_id" {
  description = "compartment id where to create all resources"
  type        = string
  # no default value, asking user to explicitly set this variable's value. see codingconventions.adoc
}

variable "provider_label_prefix" {
  description = "a string that will be prepended to all resources"
  type        = string
  default     = "terraform-oci"
}

variable "tags_freeform" {
  description = "simple key-value pairs to tag the created resources using freeform OCI Free-form tags."
  type        = map(any)
  default = {
    terraformed = "please do not edit manually"
    module      = "oracle-terraform-modules/vcn/oci"
  }
}

variable "tags_defined" {
  description = "predefined and scoped to a namespace to tag the resources created using defined tags."
  type        = map(string)
  default     = null
}

# vcn parameters

variable "create_internet_gateway" {
  description = "whether to create the internet gateway"
  type        = bool
  default     = false
}

variable "create_nat_gateway" {
  description = "whether to create a nat gateway in the vcn"
  type        = bool
  default     = false
}

variable "create_service_gateway" {
  description = "whether to create a service gateway"
  type        = bool
  default     = false
}

variable "enable_ipv6" {
  description = "Whether IPv6 is enabled for the VCN. If enabled, Oracle will assign the VCN a IPv6 /56 CIDR block."
  type        = bool
  default     = false
}

variable "lockdown_default_seclist" {
  description = "whether to remove all default security rules from the VCN Default Security List"
  type        = bool
  default     = false
}

variable "vcn_cidrs" {
  description = "The list of IPv4 CIDR blocks the VCN will use."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "vcn_dns_label" {
  description = "A DNS label for the VCN, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet"
  type        = string
  default     = "vcnmodule"
}

variable "vcn_name" {
  description = "user-friendly name of to use for the vcn to be appended to the label_prefix"
  type        = string
  default     = "vcn"
}

# gateways parameters

variable "attached_drg_id" {
  description = "the ID of DRG attached to the VCN"
  type        = string
  default     = null
}


variable "internet_gateway_display_name" {
  description = "(Updatable) Name of Internet Gateway. Does not have to be unique."
  type        = string
  default     = "igw"
}

variable "nat_gateway_display_name" {
  description = "(Updatable) Name of NAT Gateway. Does not have to be unique."
  type        = string
  default     = "ngw"
}

variable "service_gateway_display_name" {
  description = "(Updatable) Name of Service Gateway. Does not have to be unique."
  type        = string
  default     = "sgw"
}

# Public subnet parameters
variable "subnet_public_cidr_block" {
  default = "10.0.1.0/24"
}

variable "subnet_public_dns_label" {
  default = "public"
}

variable "subnet_public_prohibit_public_ip_on_vnic" {
  type        = bool
  description = "VNICs created in a public subnet will be provided a public IP"
  default     = false
}

# Private subnet parameters
variable "subnet_private_cidr_block" {
  default = "10.0.201.0/24"
}

variable "subnet_private_dns_label" {
  default = "private"
}

variable "subnet_private_prohibit_public_ip_on_vnic" {
  type        = bool
  description = "VNICs created in a private subnet will not be provided a public IP"
  default     = true
}

# Internet enabled Route table  parameters
variable "route_igw_display_name" {
  default = "igw"
}

variable "route_igw_target_cidr_block" {
  default = "0.0.0.0/0"
}

# Security list parameters
variable "sec_public_access" {
  description = "A list of CIDR blocks to which access to public access will be restricted to. *anywhere* is equivalent to 0.0.0.0/0 and allows ssh access from anywhere."
  default     = ["anywhere"]
  type        = list(any)
}

variable "sec_wireguard_access" {
  description = "A list of CIDR blocks to which access to wireguard access will be restricted to. *anywhere* is equivalent to 0.0.0.0/0 and allows ssh access from anywhere."
  default     = ["anywhere"]
  type        = list(any)
}

variable "sec_icmp_access" {
  description = "A list of CIDR blocks to which access to wireguard access will be restricted to. *anywhere* is equivalent to 0.0.0.0/0 and allows ssh access from anywhere."
  default     = ["anywhere"]
  type        = list(any)
}

variable "sec_netnum" {
  description = "0-based index of the subnet when the VCN's CIDR is masked with the corresponding newbit value."
  default     = 3
  type        = number
}

variable "sec_newbits" {
  description = "The difference between the VCN's netmask and the desired subnet mask"
  default     = 13
  type        = number
}