resource "oci_network_load_balancer_network_load_balancer" "k3sserver-ILB" {
  compartment_id                 = var.provider_compartment_id
  display_name                   = var.k3sserver-ILB_display_name
  subnet_id                      = oci_core_subnet.subnet_k3s-server.id
  is_preserve_source_destination = true
  is_private                     = true
  network_security_group_ids     = [oci_core_network_security_group.k3s-server_nsg.id]
  nlb_ip_version                 = "IPV4"
}

resource "oci_network_load_balancer_network_load_balancer" "k3sagent-ILB" {
  compartment_id                 = var.provider_compartment_id
  display_name                   = var.k3sagent-ILB_display_name
  subnet_id                      = oci_core_subnet.subnet_k3s-agent.id
  is_preserve_source_destination = true
  is_private                     = true
  network_security_group_ids     = [oci_core_network_security_group.k3s-agent_nsg.id]
  nlb_ip_version                 = "IPV4"
}

resource "oci_network_load_balancer_network_load_balancer" "k3sdb-ILB" {
  compartment_id                 = var.provider_compartment_id
  display_name                   = var.k3sdb-ILB_display_name
  subnet_id                      = oci_core_subnet.subnet_k3s-db.id
  is_preserve_source_destination = true
  is_private                     = true
  network_security_group_ids     = [oci_core_network_security_group.k3s-db_nsg.id]
  nlb_ip_version                 = "IPV4"
}

resource "oci_network_load_balancer_backend_set" "k3sserver-ILB-BackendSet" {
  is_preserve_source = true
  ip_version         = "IPv4"
  health_checker {
    protocol           = "HTTPS"
    interval_in_millis = 10000
    port               = 6443
    retries            = 3
    return_code        = 200
    timeout_in_millis  = 2000
    url_path           = "/ping"
  }
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3sserver-ILB.id
  name                     = var.k3sserver-ILB_BackendSet_name
  policy                   = var.k3sserver-ILB_BackendSet_policy
}

resource "oci_network_load_balancer_backend_set" "k3sagent-ILB-BackendSet" {
  health_checker {
    protocol           = "HTTP"
    interval_in_millis = 10000
    port               = 6443
    retries            = 3
    return_code        = 200
    timeout_in_millis  = 2000
    url_path           = "/ping"
  }
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3sagent-ILB.id
  name                     = var.k3sagent-ILB_BackendSet_name
  policy                   = var.k3sagent-ILB_BackendSet_policy
}

resource "oci_network_load_balancer_backend_set" "k3sdb-ILB-BackendSet" {
  health_checker {
    protocol           = "TCP"
    interval_in_millis = 10000
    port               = 5432
    retries            = 3
    timeout_in_millis  = 2000
  }
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3sdb-ILB.id
  name                     = var.k3sdb-ILB_BackendSet_name
  policy                   = var.k3sdb-ILB_BackendSet_policy
}

#K3s Server Listeners
resource "oci_network_load_balancer_listener" "k3sserver-ILB_Listener_6443" {
  default_backend_set_name = oci_network_load_balancer_backend_set.k3sserver-ILB-BackendSet.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3sserver-ILB.id
  name                     = var.k3sserver-ILB_Listeners.kubeapiserver.display_name
  port                     = var.k3sserver-ILB_Listeners.kubeapiserver.port
  protocol                 = var.k3sserver-ILB_Listeners.kubeapiserver.protocol
}

resource "oci_network_load_balancer_listener" "k3sserver-ILB_Listener_8472" {
  default_backend_set_name = oci_network_load_balancer_backend_set.k3sserver-ILB-BackendSet.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3sserver-ILB.id
  name                     = var.k3sserver-ILB_Listeners.wireguardvxlan.display_name
  port                     = var.k3sserver-ILB_Listeners.wireguardvxlan.port
  protocol                 = var.k3sserver-ILB_Listeners.wireguardvxlan.protocol
}

resource "oci_network_load_balancer_listener" "k3sserver-ILB_Listener_10250" {
  default_backend_set_name = oci_network_load_balancer_backend_set.k3sserver-ILB-BackendSet.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3sserver-ILB.id
  name                     = var.k3sserver-ILB_Listeners.metrics.display_name
  port                     = var.k3sserver-ILB_Listeners.metrics.port
  protocol                 = var.k3sserver-ILB_Listeners.metrics.protocol
}

resource "oci_network_load_balancer_listener" "k3sserver-ILB_Listener_51820" {
  default_backend_set_name = oci_network_load_balancer_backend_set.k3sserver-ILB-BackendSet.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3sserver-ILB.id
  name                     = var.k3sserver-ILB_Listeners.wireguardflannel.display_name
  port                     = var.k3sserver-ILB_Listeners.wireguardflannel.port
  protocol                 = var.k3sserver-ILB_Listeners.wireguardflannel.protocol
}

#K3s Agent Listeners
resource "oci_network_load_balancer_listener" "k3sagent-ILB_Listener_80" {
  default_backend_set_name = oci_network_load_balancer_backend_set.k3sagent-ILB-BackendSet.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3sagent-ILB.id
  name                     = var.k3sagent-ILB_Listeners.https.display_name
  port                     = var.k3sagent-ILB_Listeners.https.port
  protocol                 = var.k3sagent-ILB_Listeners.https.protocol
}

resource "oci_network_load_balancer_listener" "k3sagent-ILB_Listener_443" {
  default_backend_set_name = oci_network_load_balancer_backend_set.k3sagent-ILB-BackendSet.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3sagent-ILB.id
  name                     = var.k3sagent-ILB_Listeners.https.display_name
  port                     = var.k3sagent-ILB_Listeners.https.port
  protocol                 = var.k3sagent-ILB_Listeners.https.protocol
}

resource "oci_network_load_balancer_listener" "k3sagent-ILB_Listener_6443" {
  default_backend_set_name = oci_network_load_balancer_backend_set.k3sagent-ILB-BackendSet.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3sagent-ILB.id
  name                     = var.k3sagent-ILB_Listeners.kubeapiserver.display_name
  port                     = var.k3sagent-ILB_Listeners.kubeapiserver.port
  protocol                 = var.k3sagent-ILB_Listeners.kubeapiserver.protocol
}

resource "oci_network_load_balancer_listener" "k3sagent-ILB_Listener_8472" {
  default_backend_set_name = oci_network_load_balancer_backend_set.k3sagent-ILB-BackendSet.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3sagent-ILB.id
  name                     = var.k3sagent-ILB_Listeners.wireguardvxlan.display_name
  port                     = var.k3sagent-ILB_Listeners.wireguardvxlan.port
  protocol                 = var.k3sagent-ILB_Listeners.wireguardvxlan.protocol
}

resource "oci_network_load_balancer_listener" "k3sagent-ILB_Listener_10250" {
  default_backend_set_name = oci_network_load_balancer_backend_set.k3sagent-ILB-BackendSet.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3sagent-ILB.id
  name                     = var.k3sagent-ILB_Listeners.metrics.display_name
  port                     = var.k3sagent-ILB_Listeners.metrics.port
  protocol                 = var.k3sagent-ILB_Listeners.metrics.protocol
}

resource "oci_network_load_balancer_listener" "k3sagent-ILB_Listener_51820" {
  default_backend_set_name = oci_network_load_balancer_backend_set.k3sagent-ILB-BackendSet.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3sagent-ILB.id
  name                     = var.k3sagent-ILB_Listeners.wireguardflannel.display_name
  port                     = var.k3sagent-ILB_Listeners.wireguardflannel.port
  protocol                 = var.k3sagent-ILB_Listeners.wireguardflannel.protocol
}

#K3s DB Listeners
resource "oci_network_load_balancer_listener" "k3sdb-ILB_Listener_5432" {
  default_backend_set_name = oci_network_load_balancer_backend_set.k3sdb-ILB-BackendSet.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3sdb-ILB.id
  name                     = var.k3sDB-ILB_Listeners.postgresql.display_name
  port                     = var.k3sDB-ILB_Listeners.postgresql.port
  protocol                 = var.k3sDB-ILB_Listeners.postgresql.protocol
}