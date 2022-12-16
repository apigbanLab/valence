resource "oci_core_volume" "k3s-server-01-data" {
  #Required
  #TODO - PROD - disable checkov rule suppression below
  #checkov:skip=CKV_OCI_3:The volume doesn't need to be encrypted during testing phase
  #checkov:skip=CKV_OCI_2:The volume doesn't need to have backup config during testing phase
  compartment_id      = var.provider_compartment_id
  availability_domain = var.vm_availability_domain
  size_in_gbs         = var.volume_size_in_gbs
  #Optional
  display_name = "k3s-server-01-data"
  autotune_policies {
    #Required
    autotune_type = var.volume_autotune_policies_autotune_type
    #Optional
    max_vpus_per_gb = var.volume_autotune_policies_max_vpus_per_gb
  }
  vpus_per_gb = var.volume_vpus_per_gb
}

resource "oci_core_volume" "k3s-agent-01-data" {
  #Required
  #TODO - PROD - disable checkov rule suppression below
  #checkov:skip=CKV_OCI_3:The volume doesn't need to be encrypted during testing phase
  #checkov:skip=CKV_OCI_2:The volume doesn't need to have backup config during testing phase
  compartment_id      = var.provider_compartment_id
  availability_domain = var.vm_availability_domain
  size_in_gbs         = var.volume_size_in_gbs
  #Optional
  display_name = "k3s-agent-01-data"
  autotune_policies {
    #Required
    autotune_type = var.volume_autotune_policies_autotune_type
    #Optional
    max_vpus_per_gb = var.volume_autotune_policies_max_vpus_per_gb
  }
  vpus_per_gb = var.volume_vpus_per_gb
}

resource "oci_core_volume" "k3s-agent-02-data" {
  #Required
  #TODO - PROD - disable checkov rule suppression below
  #checkov:skip=CKV_OCI_3:The volume doesn't need to be encrypted during testing phase
  #checkov:skip=CKV_OCI_2:The volume doesn't need to have backup config during testing phase
  compartment_id      = var.provider_compartment_id
  availability_domain = var.vm_availability_domain
  size_in_gbs         = var.volume_size_in_gbs
  #Optional
  display_name = "k3s-agent-02-data"
  autotune_policies {
    #Required
    autotune_type = var.volume_autotune_policies_autotune_type
    #Optional
    max_vpus_per_gb = var.volume_autotune_policies_max_vpus_per_gb
  }
  vpus_per_gb = var.volume_vpus_per_gb
}


resource "oci_core_volume_attachment" "k3s-server-01-disk-attach" {
  #Required
  attachment_type = var.volume_attachment_attachment_type
  instance_id     = oci_core_instance.k3s-server-01.id
  volume_id       = oci_core_volume.k3s-server-01-data.id

  #Optional
  display_name                        = "k3s-server-01-disk-attach"
  is_pv_encryption_in_transit_enabled = var.volume_is_pv_encryption_in_transit_enabled
}

resource "oci_core_volume_attachment" "k3s-agent-01-disk-attach" {
  #Required
  attachment_type = var.volume_attachment_attachment_type
  instance_id     = oci_core_instance.k3s-agent-01.id
  volume_id       = oci_core_volume.k3s-agent-01-data.id

  #Optional
  display_name                        = "k3s-agent-01-disk-attach"
  is_pv_encryption_in_transit_enabled = var.volume_is_pv_encryption_in_transit_enabled
}

resource "oci_core_volume_attachment" "k3s-agent-02-disk-attach" {
  #Required
  attachment_type = var.volume_attachment_attachment_type
  instance_id     = oci_core_instance.k3s-agent-02.id
  volume_id       = oci_core_volume.k3s-agent-02-data.id

  #Optional
  display_name                        = "k3s-agent-02-disk-attach"
  is_pv_encryption_in_transit_enabled = var.volume_is_pv_encryption_in_transit_enabled
}