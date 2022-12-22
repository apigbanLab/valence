resource "oci_load_balancer_load_balancer" "k3sserver-ILB" {
  #Required
  compartment_id = var.provider_compartment_id
  display_name   = var.k3sserver-ILB_display_name
  shape          = var.k3sserver-ILB_shape
  subnet_ids     = [oci_core_subnet.subnet_k3s-server.id]

  #Optional
  ip_mode                    = var.k3sserver-ILB_ip_mode
  is_private                 = var.k3sserver-ILB_is_private
  network_security_group_ids = [oci_core_network_security_group.k3s-server_nsg.id]

  shape_details {
    maximum_bandwidth_in_mbps = var.k3sserver-ILB_shape_details.maximum_bandwidth_in_mbps
    minimum_bandwidth_in_mbps = var.k3sserver-ILB_shape_details.minimum_bandwidth_in_mbps
  }
}

resource "oci_load_balancer_load_balancer" "k3sagent-ILB" {
  #Required
  compartment_id = var.provider_compartment_id
  display_name   = var.k3sagent-ILB_display_name
  shape          = var.k3sagent-ILB_shape
  subnet_ids     = [oci_core_subnet.subnet_k3s-agent.id]

  #Optional
  ip_mode                    = var.k3sagent-ILB_ip_mode
  is_private                 = var.k3sagent-ILB_is_private
  network_security_group_ids = [oci_core_network_security_group.k3s-agent_nsg.id]

  shape_details {
    maximum_bandwidth_in_mbps = var.k3sagent-ILB_shape_details.maximum_bandwidth_in_mbps
    minimum_bandwidth_in_mbps = var.k3sagent-ILB_shape_details.minimum_bandwidth_in_mbps
  }
}

resource "oci_load_balancer_load_balancer" "k3sdb-ILB" {
  #Required
  compartment_id = var.provider_compartment_id
  display_name   = var.k3sdb-ILB_display_name
  shape          = var.k3sdb-ILB_shape
  subnet_ids     = [oci_core_subnet.subnet_k3s-db.id]

  #Optional
  ip_mode                    = var.k3sdb-ILB_ip_mode
  is_private                 = var.k3sdb-ILB_is_private
  network_security_group_ids = [oci_core_network_security_group.k3s-db_nsg.id]

  shape_details {
    maximum_bandwidth_in_mbps = var.k3sdb-ILB_shape_details.maximum_bandwidth_in_mbps
    minimum_bandwidth_in_mbps = var.k3sdb-ILB_shape_details.minimum_bandwidth_in_mbps
  }
}


resource "oci_load_balancer_backend_set" "k3sserver-ILB-BackendSet" {
  #Required
  health_checker {
    #Required
    protocol = "HTTP"

    #Optional
    interval_ms       = 10000
    port              = 6443
    retries           = 3
    return_code       = 200
    timeout_in_millis = 2000
    url_path          = "/readyz"
  }
  load_balancer_id = oci_load_balancer_load_balancer.k3sserver-ILB.id
  name             = var.k3sserver-ILB_BackendSet_name
  policy           = var.k3sserver-ILB_BackendSet_policy
}

resource "oci_load_balancer_backend_set" "k3sagent-ILB-BackendSet" {
  #Required
  health_checker {
    #Required
    protocol = "HTTP"

    #Optional
    interval_ms       = 10000
    port              = 6443
    retries           = 3
    return_code       = 200
    timeout_in_millis = 2000
    url_path          = "/readyz"
  }
  load_balancer_id = oci_load_balancer_load_balancer.k3sagent-ILB.id
  name             = var.k3sagent-ILB_BackendSet_name
  policy           = var.k3sagent-ILB_BackendSet_policy
}

resource "oci_load_balancer_backend_set" "k3sdb-ILB-BackendSet" {
  #Required
  health_checker {
    #Required
    protocol = "TCP"

    #Optional
    interval_ms       = 10000
    port              = 5432
    retries           = 3
    timeout_in_millis = 2000
  }
  load_balancer_id = oci_load_balancer_load_balancer.k3sdb-ILB.id
  name             = var.k3sdb-ILB_BackendSet_name
  policy           = var.k3sdb-ILB_BackendSet_policy
}

#K3s Server Listeners
resource "oci_load_balancer_listener" "k3sserver-ILB_Listener_6443" {
  #Required
  default_backend_set_name = oci_load_balancer_backend_set.k3sserver-ILB-BackendSet.name
  load_balancer_id         = oci_load_balancer_load_balancer.k3sserver-ILB.id
  name                     = var.k3sserver-ILB_Listener_kubeapiserver.display_name
  port                     = var.k3sserver-ILB_Listener_kubeapiserver.port
  protocol                 = var.k3sserver-ILB_Listener_kubeapiserver.protocol

  #Optional
  connection_configuration {
    idle_timeout_in_seconds            = var.k3sserver-ILB_Listener_connection_configuration.idle_timeout_in_seconds
    backend_tcp_proxy_protocol_version = var.k3sserver-ILB_Listener_connection_configuration.backend_tcp_proxy_protocol_version
  }
}

resource "oci_load_balancer_listener" "k3sserver-ILB_Listener_8472" {
  #Required
  default_backend_set_name = oci_load_balancer_backend_set.k3sserver-ILB-BackendSet.name
  load_balancer_id         = oci_load_balancer_load_balancer.k3sserver-ILB.id
  name                     = var.k3sserver-ILB_Listener_wireguardVxlan.display_name
  port                     = var.k3sserver-ILB_Listener_wireguardVxlan.port
  protocol                 = var.k3sserver-ILB_Listener_wireguardVxlan.protocol

  #Optional
  connection_configuration {
    idle_timeout_in_seconds            = var.k3sserver-ILB_Listener_connection_configuration.idle_timeout_in_seconds
    backend_tcp_proxy_protocol_version = var.k3sserver-ILB_Listener_connection_configuration.backend_tcp_proxy_protocol_version
  }
}

resource "oci_load_balancer_listener" "k3sserver-ILB_Listener_10250" {
  #Required
  default_backend_set_name = oci_load_balancer_backend_set.k3sserver-ILB-BackendSet.name
  load_balancer_id         = oci_load_balancer_load_balancer.k3sserver-ILB.id
  name                     = var.k3sserver-ILB_Listener_metrics.display_name
  port                     = var.k3sserver-ILB_Listener_metrics.port
  protocol                 = var.k3sserver-ILB_Listener_metrics.protocol

  #Optional
  connection_configuration {
    idle_timeout_in_seconds            = var.k3sserver-ILB_Listener_connection_configuration.idle_timeout_in_seconds
    backend_tcp_proxy_protocol_version = var.k3sserver-ILB_Listener_connection_configuration.backend_tcp_proxy_protocol_version
  }
}

resource "oci_load_balancer_listener" "k3sserver-ILB_Listener_51820" {
  #Required
  default_backend_set_name = oci_load_balancer_backend_set.k3sserver-ILB-BackendSet.name
  load_balancer_id         = oci_load_balancer_load_balancer.k3sserver-ILB.id
  name                     = var.k3sserver-ILB_Listener_flannelWireguard.display_name
  port                     = var.k3sserver-ILB_Listener_flannelWireguard.port
  protocol                 = var.k3sserver-ILB_Listener_flannelWireguard.protocol

  #Optional
  connection_configuration {
    idle_timeout_in_seconds            = var.k3sserver-ILB_Listener_connection_configuration.idle_timeout_in_seconds
    backend_tcp_proxy_protocol_version = var.k3sserver-ILB_Listener_connection_configuration.backend_tcp_proxy_protocol_version
  }
}

#K3s Agent Listeners
resource "oci_load_balancer_listener" "k3sagent-ILB_Listener_443" {
  #Required
  default_backend_set_name = oci_load_balancer_backend_set.k3sagent-ILB-BackendSet.name
  load_balancer_id         = oci_load_balancer_load_balancer.k3sagent-ILB.id
  name                     = var.k3sagent-ILB_Listener_https.display_name
  port                     = var.k3sagent-ILB_Listener_https.port
  protocol                 = var.k3sagent-ILB_Listener_https.protocol

  #Optional
  connection_configuration {
    idle_timeout_in_seconds            = var.k3sagent-ILB_Listener_connection_configuration.idle_timeout_in_seconds
    backend_tcp_proxy_protocol_version = var.k3sagent-ILB_Listener_connection_configuration.backend_tcp_proxy_protocol_version
  }
}

resource "oci_load_balancer_listener" "k3sagent-ILB_Listener_6443" {
  #Required
  default_backend_set_name = oci_load_balancer_backend_set.k3sagent-ILB-BackendSet.name
  load_balancer_id         = oci_load_balancer_load_balancer.k3sagent-ILB.id
  name                     = var.k3sagent-ILB_Listener_kubeapiserver.display_name
  port                     = var.k3sagent-ILB_Listener_kubeapiserver.port
  protocol                 = var.k3sagent-ILB_Listener_kubeapiserver.protocol

  #Optional
  connection_configuration {
    idle_timeout_in_seconds            = var.k3sagent-ILB_Listener_connection_configuration.idle_timeout_in_seconds
    backend_tcp_proxy_protocol_version = var.k3sagent-ILB_Listener_connection_configuration.backend_tcp_proxy_protocol_version
  }
}

resource "oci_load_balancer_listener" "k3sagent-ILB_Listener_8472" {
  #Required
  default_backend_set_name = oci_load_balancer_backend_set.k3sagent-ILB-BackendSet.name
  load_balancer_id         = oci_load_balancer_load_balancer.k3sagent-ILB.id
  name                     = var.k3sagent-ILB_Listener_wireguardVxlan.display_name
  port                     = var.k3sagent-ILB_Listener_wireguardVxlan.port
  protocol                 = var.k3sagent-ILB_Listener_wireguardVxlan.protocol

  #Optional
  connection_configuration {
    idle_timeout_in_seconds            = var.k3sagent-ILB_Listener_connection_configuration.idle_timeout_in_seconds
    backend_tcp_proxy_protocol_version = var.k3sagent-ILB_Listener_connection_configuration.backend_tcp_proxy_protocol_version
  }
}

resource "oci_load_balancer_listener" "k3sagent-ILB_Listener_10250" {
  #Required
  default_backend_set_name = oci_load_balancer_backend_set.k3sagent-ILB-BackendSet.name
  load_balancer_id         = oci_load_balancer_load_balancer.k3sagent-ILB.id
  name                     = var.k3sagent-ILB_Listener_metrics.display_name
  port                     = var.k3sagent-ILB_Listener_metrics.port
  protocol                 = var.k3sagent-ILB_Listener_metrics.protocol

  #Optional
  connection_configuration {
    idle_timeout_in_seconds            = var.k3sagent-ILB_Listener_connection_configuration.idle_timeout_in_seconds
    backend_tcp_proxy_protocol_version = var.k3sagent-ILB_Listener_connection_configuration.backend_tcp_proxy_protocol_version
  }
}

resource "oci_load_balancer_listener" "k3sagent-ILB_Listener_51820" {
  #Required
  default_backend_set_name = oci_load_balancer_backend_set.k3sagent-ILB-BackendSet.name
  load_balancer_id         = oci_load_balancer_load_balancer.k3sagent-ILB.id
  name                     = var.k3sagent-ILB_Listener_flannelWireguard.display_name
  port                     = var.k3sagent-ILB_Listener_flannelWireguard.port
  protocol                 = var.k3sagent-ILB_Listener_flannelWireguard.protocol

  #Optional
  connection_configuration {
    idle_timeout_in_seconds            = var.k3sagent-ILB_Listener_connection_configuration.idle_timeout_in_seconds
    backend_tcp_proxy_protocol_version = var.k3sagent-ILB_Listener_connection_configuration.backend_tcp_proxy_protocol_version
  }
}

# variable "k3sserver-ILB_Listener_default_backend_set_name" {
#   description = "K3s Servers backend set"
#   type        = string
#   default     = "k3s server backends"
# }


# variable "k3sserver-ILB_BackendSet_hc-kubeapiserver" {
#   description = "Internal LB healthchecks towards kubeapiserver"
#   type        = map(any)
#   default = {
#     #Required
#     protocol = "HTTP"
#     #Optional
#     interval_ms       = 3000
#     port              = 6443
#     retries           = 2
#     timeout_in_millis = 2000
#     url_path          = "/readyz"
#   }
# }

# variable "k3sserver-ILB_BackendSet_Policy" {
#   description = "Load Balancing Policy"
#   type        = string
#   default     = "WEIGHTED_ROUND_ROBIN"
# }

# variable "k3sserver-ILB_BackendSet_SessionPersistence" {
#   description = "Session Persistence using LB Cookies"
#   type        = map(any)
#   default = {
#     #Required
#     cookie_name = "X-Oracle-BMC-LBS-Route"
#     #Optional
#     disable_fallback = false
#   }
# }

# variable "k3sserver-ILB_BackendSet_SessionPersistence_lb_cookie_session_persistence_configuration" {
#   description = "Session Persistence using LB Cookies"
#   type        = map(any)
#   default = {
#     #Required
#     cookie_name = "X-Oracle-BMC-LBS-Route"
#     #Optional
#     disable_fallback   = false
#     is_http_only       = true
#     is_secure          = false
#     max_age_in_seconds = 30
#   }
# }