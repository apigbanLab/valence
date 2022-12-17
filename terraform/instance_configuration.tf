resource "oci_core_instance_configuration" "IC-k3sserver" {
    #Required
    compartment_id = var.provider_compartment_id

    #Optional
    source = var.IC_source-k3sserver
    display_name = var.IC_display_name-k3sserver
    instance_details {
        #Required
        instance_type = var.IC_ID_instance_type
        launch_details {
            availability_domain = var.IC_ID_LD_availability_domain
            compartment_id = var.provider_compartment_id
            create_vnic_details = var.IC_ID_LD_create_vnic_details
            instance_options {
                 are_legacy_imds_endpoints_disabled = var.vm_are_legacy_imds_endpoints_disabled
            }
            is_pv_encryption_in_transit_enabled = var.vm_is_pv_encryption_in_transit_enabled
            launch_options {
                #Optional
                boot_volume_type = var.instance_configuration_instance_details_launch_details_launch_options_boot_volume_type
                firmware = var.instance_configuration_instance_details_launch_details_launch_options_firmware
                is_consistent_volume_naming_enabled = var.instance_configuration_instance_details_launch_details_launch_options_is_consistent_volume_naming_enabled
                is_pv_encryption_in_transit_enabled = var.vm_is_pv_encryption_in_transit_enabled
            }
            metadata = var.IC_ID_LD_metadata
            preferred_maintenance_action = var.instance_configuration_instance_details_launch_details_preferred_maintenance_action
            shape = var.IC_ID_LD_shape-k3sserver
            shape_config {
                memory_in_gbs = var.instance_configuration_instance_details_launch_details_shape_config_memory_in_gbs
                ocpus = var.instance_configuration_instance_details_launch_details_shape_config_ocpus
            }
            source_details = var.IC_ID_LD_source_details-k3sserver
        }
   }
}