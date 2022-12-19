resource "random_string" "resource_code" {
  length  = 5
  special = false
  upper   = false
}

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "oci_core_instance_configuration" "IC-k3sserver" {
  compartment_id = var.provider_compartment_id
  source         = var.IC_source-k3sserver
  display_name   = "${var.IC_display_name-k3sserver}-${random_string.resource_code}"
  instance_details {
    instance_type = var.IC_ID_instance_type
    block_volumes {
      attach_details {
        type                                = var.instance_configuration_instance_details_block_volumes_attach_details_type
        device                              = var.instance_configuration_instance_details_block_volumes_attach_details_device
        display_name                        = "${var.IC_display_name-k3sserver}-${random_string.resource_code}-datadisk${format("%0000d", count.index + 1)}"
        is_pv_encryption_in_transit_enabled = var.vm_launch_options.is_pv_encryption_in_transit_enabled
      }
      create_details {
        autotune_policies {
          autotune_type   = var.volume_autotune_policies_autotune_type
          max_vpus_per_gb = var.volume_autotune_policies_max_vpus_per_gb
        }
        availability_domain = var.IC_ID_LD_availability_domain
        compartment_id      = var.provider_compartment_id
        display_name        = "${var.IC_display_name-k3sserver}-${random_string.resource_code}-datadisk${format("%0000d", count.index + 1)}"
        size_in_gbs         = var.volume_size_in_gbs
        vpus_per_gb         = var.volume_vpus_per_gb
      }
    }
    launch_details {
      availability_domain = var.IC_ID_LD_availability_domain
      compartment_id      = var.provider_compartment_id
      create_vnic_details = {
        assign_private_dns_record = var.IC_ID_LD_create_vnic_details.assign_private_dns_record
        assign_public_ip          = var.IC_ID_LD_create_vnic_details.assign_public_ip
        subnet_id                 = oci_core_subnet.subnet_k3s-server.id
        nsg_ids                   = [oci_core_network_security_group.k3s-server_nsg.id]
      }
      instance_options {
        are_legacy_imds_endpoints_disabled = var.vm_are_legacy_imds_endpoints_disabled
      }
      is_pv_encryption_in_transit_enabled = var.vm_is_pv_encryption_in_transit_enabled
      metadata = {
        "ssh_authorized_keys" = tls_private_key.ssh_key.public_key_openssh
      }
      preferred_maintenance_action = var.instance_configuration_instance_details_launch_details_preferred_maintenance_action
      shape                        = var.IC_ID_LD_shape-k3sserver
      shape_config {
        memory_in_gbs = var.instance_configuration_instance_details_launch_details_shape_config_memory_in_gbs
        ocpus         = var.instance_configuration_instance_details_launch_details_shape_config_ocpus
      }
      source_details = var.IC_ID_LD_source_details-k3sserver
    }
  }
}