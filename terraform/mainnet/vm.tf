resource "oci_core_instance" "public" {
  display_name                        = var.vm_public_instance_name
  is_pv_encryption_in_transit_enabled = var.vm_is_pv_encryption_in_transit_enabled
  availability_domain                 = var.vm_availability_domain
  compartment_id                      = var.provider_compartment_id
  shape                               = var.vm_shape
  metadata = {
    "ssh_authorized_keys" = var.vm_ssh_authorized_keys
  }

  shape_config {
    memory_in_gbs = var.vm_shape_config.memory_in_gbs
    ocpus         = var.vm_shape_config.ocpus
  }

  create_vnic_details {
    assign_private_dns_record = "true"
    assign_public_ip          = "true"
    subnet_id                 = oci_core_subnet.public_subnet.id
  }

  availability_config {
    recovery_action = var.vm_availability_config.recovery_action
  }

  source_details {
    source_id   = var.vm_image_source_details.source_id
    source_type = var.vm_image_source_details.source_type
  }

  agent_config {
    is_management_disabled = "false"
    is_monitoring_disabled = "false"
    plugins_config {
      desired_state = "DISABLED"
      name          = "Vulnerability Scanning"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "Compute Instance Monitoring"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "Bastion"
    }
  }
}

resource "oci_core_volume" "disk-one" {
  #Required
  compartment_id      = var.provider_compartment_id
  availability_domain = var.vm_availability_domain
  size_in_gbs         = var.volume_size_in_gbs
  #Optional
  autotune_policies {
    #Required
    autotune_type = var.volume_autotune_policies_autotune_type
    #Optional
    max_vpus_per_gb = var.volume_autotune_policies_max_vpus_per_gb
  }
  vpus_per_gb = var.volume_vpus_per_gb
}

resource "oci_core_volume_attachment" "disk-one-attachment" {
  #Required
  attachment_type = var.volume_attachment_attachment_type
  instance_id     = oci_core_instance.public.id
  volume_id       = oci_core_volume.disk-one.id

  #Optional
  display_name                        = var.volume_attachment_display_name
  is_pv_encryption_in_transit_enabled = var.volume_is_pv_encryption_in_transit_enabled
}