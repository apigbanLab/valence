resource "oci_core_instance_pool" "IP-k3sserver" {
    compartment_id = var.provider_compartment_id
    instance_configuration_id = oci_core_instance_configuration.IC-k3sserver.id
    placement_configurations {
        availability_domain = var.IC_ID_LD_availability_domain
        primary_subnet_id = oci_core_subnet.k3sserver.id
    }
    size = var.k3sserver-IP_size
    display_name = var.k3sserver-IP_display_name
    # load_balancers {
    #     #Required - TODO:
    #     backend_set_name = oci_load_balancer_backend_set.test_backend_set.name
    #     load_balancer_id = oci_load_balancer_load_balancer.test_load_balancer.id
    #     port = var.instance_pool_load_balancers_port
    #     vnic_selection = var.instance_pool_load_balancers_vnic_selection
    # }
}