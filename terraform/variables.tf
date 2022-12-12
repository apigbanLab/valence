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

# variable "tags_freeform" {
#   description = "simple key-value pairs to tag the created resources using freeform OCI Free-form tags."
#   type        = map(any)
#   default = {
#     terraformed = "please do not edit manually"
#     module      = "oracle-terraform-modules/vcn/oci"
#   }
# }

# variable "tags_defined" {
#   description = "predefined and scoped to a namespace to tag the resources created using defined tags."
#   type        = map(string)
#   default     = null
# }

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

# variable "enable_ipv6" {
#   description = "Whether IPv6 is enabled for the VCN. If enabled, Oracle will assign the VCN a IPv6 /56 CIDR block."
#   type        = bool
#   default     = false
# }

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

# variable "nat_gateway_display_name" {
#   description = "(Updatable) Name of NAT Gateway. Does not have to be unique."
#   type        = string
#   default     = "ngw"
# }

# variable "service_gateway_display_name" {
#   description = "(Updatable) Name of Service Gateway. Does not have to be unique."
#   type        = string
#   default     = "sgw"
# }

# k3s-agent subnet parameters
variable "subnet_k3s-agent_cidr_block" {
  type    = string
  default = "10.0.1.0/24"
}

variable "subnet_k3s-agent_dns_label" {
  type    = string
  default = "k3s-agent"
}

variable "subnet_k3s-agent_prohibit_public_ip_on_vnic" {
  type        = bool
  description = "VNICs created in a public subnet will be provided a public IP"
  default     = false
}

# k3s-server subnet parameters
variable "subnet_k3s-server_cidr_block" {
  type    = string
  default = "10.0.201.0/24"
}

variable "subnet_k3s-server_dns_label" {
  type    = string
  default = "private"
}

variable "subnet_k3s-server_prohibit_public_ip_on_vnic" {
  type        = bool
  description = "VNICs created in a private subnet will not be provided a public IP"
  default     = true
}

# k3s-db subnet parameters
variable "subnet_k3s-db_cidr_block" {
  type    = string
  default = "10.0.201.0/24"
}

variable "subnet_k3s-db_dns_label" {
  type    = string
  default = "private"
}

variable "subnet_k3s-db_prohibit_public_ip_on_vnic" {
  type        = bool
  description = "VNICs created in a private subnet will not be provided a public IP"
  default     = true
}

# Internet enabled Route table  parameters
# variable "route_igw_display_name" {
#   type    = string
#   default = "igw"
# }

# variable "route_igw_target_cidr_block" {
#   type    = string
#   default = "0.0.0.0/0"
# }

# Security list parameters
variable "sec_public_access" {
  description = "A list of CIDR blocks to which access to public access will be restricted to. *anywhere* is equivalent to 0.0.0.0/0 and allows ssh access from anywhere."
  default     = ["anywhere"]
  type        = list(any)
}

variable "sec_wireguard_flannel_vxlan_access" {
  description = "A list of CIDR blocks to which access to wireguard access will be restricted to. *anywhere* is equivalent to 0.0.0.0/0 and allows ssh access from anywhere."
  default     = ["10.0.1.0/24","10.0.201.0/24"]
  type        = list(any)
}

variable "sec_wireguard_flannel_ipv4_access" {
  description = "A list of CIDR blocks to which access to wireguard_flannel access will be restricted to. *anywhere* is equivalent to 0.0.0.0/0 and allows access from anywhere."
  default     = ["10.0.1.0/24","10.0.201.0/24"]
  type        = list(any)
}

variable "sec_kube_metrics_access" {
  description = "A list of CIDR blocks to which access to kube_metrics access will be restricted to. *anywhere* is equivalent to 0.0.0.0/0 and allows access from anywhere."
  default     = ["10.0.1.0/24","10.0.201.0/24"]
  type        = list(any)
}

variable "sec_k3s_apiserver_access" {
  description = "A list of CIDR blocks to which access to k3s access will be restricted to. *anywhere* is equivalent to 0.0.0.0/0 and allows access from anywhere."
  default     = ["10.0.201.0/24"]
  type        = list(any)
}

# variable "sec_icmp_access" {
#   description = "A list of CIDR blocks to which access to wireguard access will be restricted to. *anywhere* is equivalent to 0.0.0.0/0 and allows ssh access from anywhere."
#   default     = ["anywhere"]
#   type        = list(any)
# }

# variable "sec_netnum" {
#   description = "0-based index of the subnet when the VCN's CIDR is masked with the corresponding newbit value."
#   default     = 3
#   type        = number
# }

# variable "sec_newbits" {
#   description = "The difference between the VCN's netmask and the desired subnet mask"
#   default     = 13
#   type        = number
# }

variable "vm_server_shape" {
  description = "The shape of an instance. The shape determines the number of CPUs, amount of memory, and other resources allocated to the instance."
  type        = string
  default     = "VM.Standard.E2.1.Micro"
}

variable "vm_agent_shape" {
  description = "The shape of an instance. The shape determines the number of CPUs, amount of memory, and other resources allocated to the instance."
  type        = string
  default     = "VM.Standard.A1.Flex"
}

variable "vm_db_shape" {
  description = "The shape of an instance. The shape determines the number of CPUs, amount of memory, and other resources allocated to the instance."
  type        = string
  default     = "VM.Standard.A1.Flex"
}

variable "vm_k3s_server_shape_config" {
  description = "The shape configuration requested for the instance."
  type        = map(any)
  default = {
    memory_in_gbs = "1"
    ocpus         = "1"
  }
}

variable "vm_k3s_agent_shape_config" {
  description = "The shape configuration requested for the instance."
  type        = map(any)
  default = {
    memory_in_gbs = "6"
    ocpus         = "1"
  }
}

variable "vm_k3s_db_shape_config" {
  description = "The shape configuration requested for the instance."
  type        = map(any)
  default = {
    memory_in_gbs = "6"
    ocpus         = "1"
  }
}

variable "vm_is_pv_encryption_in_transit_enabled" {
  description = "Whether to enable in-transit encryption for the data volume's paravirtualized attachment."
  type        = bool
  default     = true
}

variable "vm_are_legacy_imds_endpoints_disabled" {
  type    = string
  default = true
}

variable "vm_availability_config" {
  type = map(any)
  default = {
    recovery_action = "RESTORE_INSTANCE"
  }
}

variable "vm_availability_domain" {
  type    = string
  default = "ChLp:ME-DUBAI-1-AD-1"
}

# variable "vm_public_instance_name" {
#   type    = string
#   default = "one"
# }

variable "vm_image_source_details" {
  type = map(any)
  default = {
    source_id   = "ocid1.image.oc1.me-dubai-1.aaaaaaaa7jbzbtjqppye75wes5qmvlobsn3cvp2dvarym365wnem7r2celwq"
    source_type = "image"
  }
}

variable "vm_launch_options" {
  type = map(any)
  default = {
    is_pv_encryption_in_transit_enabled = true
    network_type                        = "PARAVIRTUALIZED"
  }
}
# variable "volume_display_name" {
#   type    = string
#   default = "disk-one"
# }

variable "volume_attachment_attachment_type" {
  type    = string
  default = "paravirtualized"
}

variable "volume_autotune_policies_autotune_type" {
  type    = string
  default = "PERFORMANCE_BASED"
}

variable "volume_autotune_policies_max_vpus_per_gb" {
  type    = string
  default = "20"
}

variable "volume_vpus_per_gb" {
  type    = string
  default = "10"
}

variable "volume_size_in_gbs" {
  type    = string
  default = "50"
}

# variable "volume_attachment_display_name" {
#   type    = string
#   default = "disk-attachment"
# }

variable "volume_is_pv_encryption_in_transit_enabled" {
  type    = bool
  default = true
}

# variable "key_name" {
#   type    = string
#   default = "ssh_key"
# }