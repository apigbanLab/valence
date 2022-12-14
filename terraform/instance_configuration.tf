resource "random_string" "resource_code" {
  length  = 5
  special = false
  upper   = false
}

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# cloud-init config
data "cloudinit_config" "k3s-server-cfg" {
  gzip          = true
  base64_encode = true
  part {
    content_type = "text/cloud-config"
    content      = file("scripts/cloud-config.cfg")
  }
}

data "cloudinit_config" "k3s-agent-cfg" {
  gzip          = true
  base64_encode = true
  part {
    content_type = "text/cloud-config"
    content      = file("scripts/cloud-config.cfg")
  }
}

data "cloudinit_config" "k3s-db-cfg" {
  gzip          = true
  base64_encode = true
  part {
    content_type = "text/cloud-config"
    content      = file("scripts/cloud-config.cfg")
  }
}

resource "oci_core_instance_configuration" "IC-k3sserver" {
  compartment_id = var.provider_compartment_id
  source         = var.IC_source-k3sserver
  display_name   = var.IC_display_name-k3sserver
  instance_details {
    instance_type = var.IC_ID_instance_type
    block_volumes {
      attach_details {
        type                                = var.volume_attachment_attachment_type
        display_name                        = "${var.IC_display_name-k3sserver}-datadisk-${random_string.resource_code.result}"
        is_pv_encryption_in_transit_enabled = var.vm_launch_options.is_pv_encryption_in_transit_enabled
      }
      create_details {
        autotune_policies {
          autotune_type   = var.volume_autotune_policies_autotune_type
          max_vpus_per_gb = var.volume_autotune_policies_max_vpus_per_gb
        }
        availability_domain = var.IC_ID_LD_availability_domain
        compartment_id      = var.provider_compartment_id
        display_name        = "${var.IC_display_name-k3sserver}-datadisk-${random_string.resource_code.result}"
        size_in_gbs         = var.volume_size_in_gbs
        vpus_per_gb         = var.volume_vpus_per_gb
      }
    }
    launch_details {
      availability_domain = var.IC_ID_LD_availability_domain
      compartment_id      = var.provider_compartment_id
      create_vnic_details {
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
        "ssh_authorized_keys" : tls_private_key.ssh_key.public_key_openssh
        "user_data" : data.cloudinit_config.k3s-server-cfg.rendered
      }
      shape = var.IC_ID_LD_shape-k3sserver
      shape_config {
        memory_in_gbs = var.IC_ID_LD_shape_config-k3sserver.memory_in_gbs
        ocpus         = var.IC_ID_LD_shape_config-k3sserver.ocpus
      }
      source_details {
        source_type = var.IC_ID_LD_source_details-k3sserver.source_type

        #Optional
        boot_volume_size_in_gbs = var.IC_ID_LD_source_details-k3sserver.boot_volume_size_in_gbs
        boot_volume_vpus_per_gb = var.IC_ID_LD_source_details-k3sserver.boot_volume_vpus_per_gb
        image_id                = var.IC_ID_LD_source_details-k3sserver.source_id
      }
    }
  }
}

resource "oci_core_instance_configuration" "IC-k3sagent" {
  compartment_id = var.provider_compartment_id
  source         = var.IC_source-k3sagent
  display_name   = var.IC_display_name-k3sagent
  instance_details {
    instance_type = var.IC_ID_instance_type
    block_volumes {
      attach_details {
        type                                = var.volume_attachment_attachment_type
        display_name                        = "${var.IC_display_name-k3sagent}-datadisk-${random_string.resource_code.result}"
        is_pv_encryption_in_transit_enabled = var.vm_launch_options.is_pv_encryption_in_transit_enabled
      }
      create_details {
        autotune_policies {
          autotune_type   = var.volume_autotune_policies_autotune_type
          max_vpus_per_gb = var.volume_autotune_policies_max_vpus_per_gb
        }
        availability_domain = var.IC_ID_LD_availability_domain
        compartment_id      = var.provider_compartment_id
        display_name        = "${var.IC_display_name-k3sagent}-datadisk-${random_string.resource_code.result}"
        size_in_gbs         = var.volume_size_in_gbs
        vpus_per_gb         = var.volume_vpus_per_gb
      }
    }
    launch_details {
      availability_domain = var.IC_ID_LD_availability_domain
      compartment_id      = var.provider_compartment_id
      create_vnic_details {
        assign_private_dns_record = var.IC_ID_LD_create_vnic_details.assign_private_dns_record
        assign_public_ip          = var.IC_ID_LD_create_vnic_details.assign_public_ip
        subnet_id                 = oci_core_subnet.subnet_k3s-agent.id
        nsg_ids                   = [oci_core_network_security_group.k3s-agent_nsg.id]
      }
      instance_options {
        are_legacy_imds_endpoints_disabled = var.vm_are_legacy_imds_endpoints_disabled
      }
      is_pv_encryption_in_transit_enabled = var.vm_is_pv_encryption_in_transit_enabled
      metadata = {
        "ssh_authorized_keys" : tls_private_key.ssh_key.public_key_openssh
        "user_data" : data.cloudinit_config.k3s-agent-cfg.rendered
      }
      shape = var.IC_ID_LD_shape-k3sagent
      shape_config {
        memory_in_gbs = var.IC_ID_LD_shape_config-k3sagent.memory_in_gbs
        ocpus         = var.IC_ID_LD_shape_config-k3sagent.ocpus
      }
      source_details {
        source_type = var.IC_ID_LD_source_details-k3sagent.source_type

        #Optional
        boot_volume_size_in_gbs = var.IC_ID_LD_source_details-k3sagent.boot_volume_size_in_gbs
        boot_volume_vpus_per_gb = var.IC_ID_LD_source_details-k3sagent.boot_volume_vpus_per_gb
        image_id                = var.IC_ID_LD_source_details-k3sagent.source_id
      }
    }
  }
}

resource "oci_core_instance_configuration" "IC-k3sdb" {
  compartment_id = var.provider_compartment_id
  source         = var.IC_source-k3sdb
  display_name   = var.IC_display_name-k3sdb
  instance_details {
    instance_type = var.IC_ID_instance_type
    block_volumes {
      attach_details {
        type                                = var.volume_attachment_attachment_type
        display_name                        = "${var.IC_display_name-k3sdb}-datadisk-${random_string.resource_code.result}"
        is_pv_encryption_in_transit_enabled = var.vm_launch_options.is_pv_encryption_in_transit_enabled
      }
      create_details {
        autotune_policies {
          autotune_type   = var.volume_autotune_policies_autotune_type
          max_vpus_per_gb = var.volume_autotune_policies_max_vpus_per_gb
        }
        availability_domain = var.IC_ID_LD_availability_domain
        compartment_id      = var.provider_compartment_id
        display_name        = "${var.IC_display_name-k3sdb}-datadisk-${random_string.resource_code.result}"
        size_in_gbs         = var.volume_size_in_gbs
        vpus_per_gb         = var.volume_vpus_per_gb
      }
    }
    launch_details {
      availability_domain = var.IC_ID_LD_availability_domain
      compartment_id      = var.provider_compartment_id
      create_vnic_details {
        assign_private_dns_record = var.IC_ID_LD_create_vnic_details.assign_private_dns_record
        assign_public_ip          = var.IC_ID_LD_create_vnic_details.assign_public_ip
        subnet_id                 = oci_core_subnet.subnet_k3s-db.id
        nsg_ids                   = [oci_core_network_security_group.k3s-db_nsg.id]
      }
      instance_options {
        are_legacy_imds_endpoints_disabled = var.vm_are_legacy_imds_endpoints_disabled
      }
      is_pv_encryption_in_transit_enabled = var.vm_is_pv_encryption_in_transit_enabled
      metadata = {
        "ssh_authorized_keys" : tls_private_key.ssh_key.public_key_openssh
        "user_data" : data.cloudinit_config.k3s-db-cfg.rendered
      }
      shape = var.IC_ID_LD_shape-k3sdb
      shape_config {
        memory_in_gbs = var.IC_ID_LD_shape_config-k3sdb.memory_in_gbs
        ocpus         = var.IC_ID_LD_shape_config-k3sdb.ocpus
      }
      source_details {
        source_type = var.IC_ID_LD_source_details-k3sdb.source_type

        #Optional
        boot_volume_size_in_gbs = var.IC_ID_LD_source_details-k3sdb.boot_volume_size_in_gbs
        boot_volume_vpus_per_gb = var.IC_ID_LD_source_details-k3sdb.boot_volume_vpus_per_gb
        image_id                = var.IC_ID_LD_source_details-k3sdb.source_id
      }
    }
  }
}