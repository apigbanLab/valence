resource "oci_core_volume" "disk-one" {
  #Required
  compartment_id      = var.provider_compartment_id
  availability_domain = var.vm_availability_domain
  size_in_gbs         = var.volume_size_in_gbs
  #Optional
  display_name = var.volume_display_name
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