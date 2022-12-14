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

# k3s-agent subnet parameters
variable "subnet_k3s-agent_cidr_block" {
  type    = string
  default = "10.0.1.0/24"
}

variable "subnet_k3s-agent_dns_label" {
  type    = string
  default = "k3sagent"
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
  default = "k3sserver"
}

variable "subnet_k3s-server_prohibit_public_ip_on_vnic" {
  type        = bool
  description = "VNICs created in a private subnet will not be provided a public IP"
  default     = false
}

# k3s-db subnet parameters
variable "subnet_k3s-db_cidr_block" {
  type    = string
  default = "10.0.101.0/24"
}

variable "subnet_k3s-db_dns_label" {
  type    = string
  default = "k3sdb"
}

variable "subnet_k3s-db_prohibit_public_ip_on_vnic" {
  type        = bool
  description = "VNICs created in a private subnet will not be provided a public IP"
  default     = false
}

#K3s Server - Internal LB - Parameters
variable "k3sserver-ILB_display_name" {
  type    = string
  default = "k3sserver-ILB"
}

variable "k3sserver-ILB_BackendSet_policy" {
  type    = string
  default = "FIVE_TUPLE"
}

#K3s Agent - Internal LB - Parameters
variable "k3sagent-ILB_display_name" {
  type    = string
  default = "k3sagent-ILB"
}

variable "k3sagent-ILB_BackendSet_policy" {
  type    = string
  default = "FIVE_TUPLE"
}

variable "k3sserver-ILB_Listeners" {
  type = object({
    wireguardflannel = object(
      {
        display_name = string
        port         = number
        protocol     = string
      }
    )
    metrics = object(
      {
        display_name = string
        port         = number
        protocol     = string
      }
    )
    https = object(
      {
        display_name = string
        port         = number
        protocol     = string
      }
    )
    wireguardvxlan = object(
      {
        display_name = string
        port         = number
        protocol     = string
      }
    )
    kubeapiserver = object(
      {
        display_name            = string
        port                    = number
        protocol                = string
        be_healthcheck_protocol = string
      }
    )
  })
  default = {
    wireguardflannel = {
      "display_name" = "wireguardflannel"
      "port"         = 51820
      "protocol"     = "UDP"
    }
    metrics = {
      "display_name" = "metrics"
      "port"         = 10250
      "protocol"     = "TCP"
    }
    https = {
      "display_name" = "https"
      "port"         = 443
      "protocol"     = "TCP"
    }
    wireguardvxlan = {
      "display_name" = "wireguardVxlan"
      "port"         = 8472
      "protocol"     = "UDP"
    }
    kubeapiserver = {
      "display_name"            = "kubeapiserver"
      "port"                    = 6443
      "protocol"                = "TCP"
      "be_healthcheck_protocol" = "HTTPS"
    }
  }
}

variable "k3sagent-ILB_Listeners" {
  type = object({
    wireguardflannel = object(
      {
        display_name = string
        port         = number
        protocol     = string
      }
    )
    metrics = object(
      {
        display_name = string
        port         = number
        protocol     = string
      }
    )
    http = object(
      {
        display_name = string
        port         = number
        protocol     = string
      }
    )
    https = object(
      {
        display_name = string
        port         = number
        protocol     = string
      }
    )
    wireguardvxlan = object(
      {
        display_name = string
        port         = number
        protocol     = string
      }
    )
    kubeapiserver = object(
      {
        display_name            = string
        port                    = number
        protocol                = string
        be_healthcheck_protocol = string
      }
    )
  })
  default = {
    wireguardflannel = {
      "display_name" = "wireguardflannel"
      "port"         = 51820
      "protocol"     = "UDP"
    }
    metrics = {
      "display_name" = "metrics"
      "port"         = 10250
      "protocol"     = "TCP"
    }
    http = {
      "display_name" = "http"
      "port"         = 80
      "protocol"     = "TCP"
    }
    https = {
      "display_name" = "https"
      "port"         = 443
      "protocol"     = "TCP"
    }
    wireguardvxlan = {
      "display_name" = "wireguardVxlan"
      "port"         = 8472
      "protocol"     = "UDP"
    }
    kubeapiserver = {
      "display_name"            = "kubeapiserver"
      "port"                    = 6443
      "protocol"                = "TCP"
      "be_healthcheck_protocol" = "HTTPS"
    }
  }
}

#K3s DB - Internal LB - Parameters
variable "k3sdb-ILB_display_name" {
  type    = string
  default = "k3sdb-ILB"
}

variable "k3sdb-ILB_BackendSet_policy" {
  type    = string
  default = "FIVE_TUPLE"
}

variable "k3sDB-ILB_Listeners" {
  type = object({
    postgresql = object(
      {
        display_name = string
        port         = number
        protocol     = string
      }
    )
  })
  default = {
    postgresql = {
      "display_name" = "postgresql"
      "port"         = 5432
      "protocol"     = "TCP"
    }
  }
}

# K3s Server Instance Configuration parameters

variable "IC_display_name-k3sserver" {
  type    = string
  default = "k3sserver"
}

variable "IC_ID_instance_type" {
  type    = string
  default = "compute"
}

variable "IC_ID_LD_availability_domain" {
  type    = string
  default = "ChLp:ME-DUBAI-1-AD-1"
}

variable "IC_ID_LD_create_vnic_details" {
  type = map(any)
  default = {
    assign_private_dns_record = "true"
    assign_public_ip          = "true"
  }
}

variable "IC_ID_LD_shape-k3sserver" {
  type    = string
  default = "VM.Standard.E2.1.Micro"
}

variable "IC_ID_LD_shape_config-k3sserver" {
  description = "The shape configuration requested for the instance."
  type        = map(any)
  default = {
    memory_in_gbs = "1"
    ocpus         = "1"
  }
}

variable "IC_ID_LD_source_details-k3sserver" {
  type = map(any)
  default = {
    source_id               = "ocid1.image.oc1.me-dubai-1.aaaaaaaa5ickw7n4ds2qn7b2xjlrdoo7bbpts4i4wbolr6q36k33awbzjexa"
    source_type             = "image"
    boot_volume_size_in_gbs = 50
    boot_volume_vpus_per_gb = 10
  }
}

variable "IC_source-k3sserver" {
  type    = string
  default = "NONE"
}

# K3s Server Instance Configuration parameters
variable "IC_display_name-k3sagent" {
  type    = string
  default = "k3sagent"
}

variable "IC_ID_LD_shape-k3sagent" {
  type    = string
  default = "VM.Standard.A1.Flex"
}

variable "IC_ID_LD_shape_config-k3sagent" {
  description = "The shape configuration requested for the instance."
  type        = map(any)
  default = {
    memory_in_gbs = "6"
    ocpus         = "1"
  }
}

variable "IC_ID_LD_source_details-k3sagent" {
  type = map(any)
  default = {
    source_id               = "ocid1.image.oc1.me-dubai-1.aaaaaaaa7jbzbtjqppye75wes5qmvlobsn3cvp2dvarym365wnem7r2celwq"
    source_type             = "image"
    boot_volume_size_in_gbs = 50
    boot_volume_vpus_per_gb = 10
  }
}

variable "IC_source-k3sagent" {
  type    = string
  default = "NONE"
}

# K3s DB Instance Configuration parameters
variable "IC_display_name-k3sdb" {
  type    = string
  default = "k3sdb"
}

variable "IC_ID_LD_shape-k3sdb" {
  type    = string
  default = "VM.Standard.A1.Flex"
}

variable "IC_ID_LD_shape_config-k3sdb" {
  description = "The shape configuration requested for the instance."
  type        = map(any)
  default = {
    memory_in_gbs = "6"
    ocpus         = "1"
  }
}

variable "IC_ID_LD_source_details-k3sdb" {
  type = map(any)
  default = {
    source_id               = "ocid1.image.oc1.me-dubai-1.aaaaaaaa7jbzbtjqppye75wes5qmvlobsn3cvp2dvarym365wnem7r2celwq"
    source_type             = "image"
    boot_volume_size_in_gbs = 50
    boot_volume_vpus_per_gb = 10
  }
}

variable "IC_source-k3sdb" {
  type    = string
  default = "NONE"
}

# variable "vm_server_shape" {
#   description = "The shape of an instance. The shape determines the number of CPUs, amount of memory, and other resources allocated to the instance."
#   type        = string
#   default     = "VM.Standard.E2.1.Micro"
# }

# variable "vm_agent_shape" {
#   description = "The shape of an instance. The shape determines the number of CPUs, amount of memory, and other resources allocated to the instance."
#   type        = string
#   default     = "VM.Standard.A1.Flex"
# }

# variable "vm_db_shape" {
#   description = "The shape of an instance. The shape determines the number of CPUs, amount of memory, and other resources allocated to the instance."
#   type        = string
#   default     = "VM.Standard.A1.Flex"
# }

# variable "vm_k3s_server_shape_config" {
#   description = "The shape configuration requested for the instance."
#   type        = map(any)
#   default = {
#     memory_in_gbs = "1"
#     ocpus         = "1"
#   }
# }

# variable "vm_k3s_agent_shape_config" {
#   description = "The shape configuration requested for the instance."
#   type        = map(any)
#   default = {
#     memory_in_gbs = "6"
#     ocpus         = "1"
#   }
# }

# variable "vm_k3s_db_shape_config" {
#   description = "The shape configuration requested for the instance."
#   type        = map(any)
#   default = {
#     memory_in_gbs = "6"
#     ocpus         = "1"
#   }
# }

variable "vm_is_pv_encryption_in_transit_enabled" {
  description = "Whether to enable in-transit encryption for the data volume's paravirtualized attachment."
  type        = bool
  default     = true
}

variable "vm_are_legacy_imds_endpoints_disabled" {
  type    = string
  default = true
}

# variable "vm_availability_config" {
#   type = map(any)
#   default = {
#     recovery_action = "RESTORE_INSTANCE"
#   }
# }

# variable "vm_availability_domain" {
#   type    = string
#   default = "ChLp:ME-DUBAI-1-AD-1"
# }

# variable "vm_public_instance_name" {
#   type    = string
#   default = "one"
# }

# variable "vm_x86_image_source_details" {
#   type = map(any)
#   default = {
#     source_id   = "ocid1.image.oc1.me-dubai-1.aaaaaaaa5ickw7n4ds2qn7b2xjlrdoo7bbpts4i4wbolr6q36k33awbzjexa"
#     source_type = "image"
#   }
# }

# variable "vm_aarch64_image_source_details" {
#   type = map(any)
#   default = {
#     source_id   = "ocid1.image.oc1.me-dubai-1.aaaaaaaa7jbzbtjqppye75wes5qmvlobsn3cvp2dvarym365wnem7r2celwq"
#     source_type = "image"
#   }
# }


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

# variable "volume_is_pv_encryption_in_transit_enabled" {
#   type    = bool
#   default = true
# }

# variable "key_name" {
#   type    = string
#   default = "ssh_key"
# }

variable "workstation_publicIPAddress" {
  description = "The current Public IP address where terraform apply is going to be executed"
  type        = string
}

# K3s Server Instance Pool Parameters
variable "k3sserver-IP_display_name" {
  type    = string
  default = "k3sserver"
}

variable "k3sserver-IP_size" {
  type    = number
  default = 1
}

# Autoscaling Parameters
variable "k3sserver-ASC_target_type" {
  type    = string
  default = "instancePool"
}

variable "k3sserver-ASC_policies_display_name" {
  type    = string
  default = "k3sserver-ASC"
}

variable "k3sserver-ASC_policies_capacity_max" {
  type    = number
  default = 2
}

variable "k3sserver-ASC_policies_capacity_min" {
  type    = number
  default = 1
}

variable "k3sserver-ASC_policies_capacity_initial" {
  type    = number
  default = 1
}

variable "k3sserver-ASC_policies_policy_type" {
  type    = string
  default = "threshold"
}
variable "k3sserver-ASC_policies_rules_display_name" {
  type    = string
  default = "k3sserver-autoscale"
}

# K3s Agent Instance Pool Parameters
variable "k3sagent-IP_display_name" {
  type    = string
  default = "k3sagent"
}

variable "k3sagent-IP_size" {
  type    = number
  default = 1
}

# K3s Agent Autoscaling Parameters
variable "k3sagent-ASC_target_type" {
  type    = string
  default = "instancePool"
}

variable "k3sagent-ASC_policies_display_name" {
  type    = string
  default = "k3sagent-ASC"
}

variable "k3sagent-ASC_policies_capacity_max" {
  type    = number
  default = 5
}

variable "k3sagent-ASC_policies_capacity_min" {
  type    = number
  default = 1
}

variable "k3sagent-ASC_policies_capacity_initial" {
  type    = number
  default = 1
}

variable "k3sagent-ASC_policies_policy_type" {
  type    = string
  default = "threshold"
}
variable "k3sagent-ASC_policies_rules_display_name" {
  type    = string
  default = "k3sagent-autoscale"
}

# K3s DB Instance Pool Parameters
variable "k3sdb-IP_display_name" {
  type    = string
  default = "k3sdb"
}

variable "k3sdb-IP_size" {
  type    = number
  default = 1
}

variable "k3sdb-IP_role" {
  type    = string
  default = "external_datastore"
}

variable "k3sserver-IP_role" {
  type    = string
  default = "controlplane"
}

variable "k3sagent-IP_role" {
  type    = string
  default = "worker"
}

#K3s DB Autoscaling Parameters
variable "k3sdb-ASC_target_type" {
  type    = string
  default = "instancePool"
}

variable "k3sdb-ASC_policies_display_name" {
  type    = string
  default = "k3sdb-ASC"
}

variable "k3sdb-ASC_policies_capacity_max" {
  type    = number
  default = 5
}

variable "k3sdb-ASC_policies_capacity_min" {
  type    = number
  default = 1
}

variable "k3sdb-ASC_policies_capacity_initial" {
  type    = number
  default = 1
}

variable "k3sdb-ASC_policies_policy_type" {
  type    = string
  default = "threshold"
}
variable "k3sdb-ASC_policies_rules_display_name" {
  type    = string
  default = "k3sdb-autoscale"
}

# variable "k3sserver-ASC-policies_rules_metric_threshold_operator_GTE" {
#   type    = string
#   default = "GTE"
# }