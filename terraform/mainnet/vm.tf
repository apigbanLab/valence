resource "oci_core_instance" "public" {
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
  availability_config = var.vm_availability_config
  availability_domain = var.vm_availability_domain
  compartment_id      = var.provider_compartment_id
  create_vnic_details {
    assign_private_dns_record = "true"
    assign_public_ip          = "true"
    subnetId                  = oci_core_subnet.public_subnet.id
  }
  display_name                        = var.vm_public_instance_name
  instance_options                    = var.vm_instance_options
  is_pv_encryption_in_transit_enabled = var.vm_is_pv_encryption_in_transit_enabled
  metadata = {
    "ssh_authorized_keys" = var.vm_ssh_authorized_keys
  }
  shape          = var.vm_shape
  shape_config   = var.vm_shape_config
  source_details = var.vm_image_source_details
}
