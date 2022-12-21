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

resource "oci_load_balancer_backend_set" "k3sserver-ILB-BackendSet" {
  #Required
  health_checker {
    #Required
    protocol = "TCP"

    #Optional
    interval_ms       = 10000
    port              = 6443
    retries           = 3
    return_code       = 200
    timeout_in_millis = 2000
    url_path          = "/readyz"
  }
  load_balancer_id                  = oci_load_balancer_load_balancer.k3sserver-ILB.id
  name                              = var.k3sserver-ILB_BackendSet_name
  policy                            = var.k3sserver-ILB_BackendSet_policy
}

# #K3sserver Listeners
# resource "oci_load_balancer_listener" "k3sserver" {
#   #Required
#   default_backend_set_name = oci_load_balancer_backend_set.test_backend_set.name
#   load_balancer_id         = oci_load_balancer_load_balancer.k3sserver-lb.id
#   name                     = var.k3sserver-ILB_Listener_display_name-kubeapiserver
#   port                     = var.k3sserver-ILB_Listener_port-kubeapiserver
#   protocol                 = var.k3sserver-ILB_Listener_protocol-kubeapiserver

#   #Optional
#   connection_configuration = var.k3sserver-ILB_Listener_connection_configuration
#   routing_policy_name      = oci_load_balancer_load_balancer_routing_policy.test_load_balancer_routing_policy.name
#   rule_set_names           = [oci_load_balancer_rule_set.test_rule_set.name]
#   #TODO:
#   ssl_configuration {
#     #Optional
#     certificate_name                  = oci_load_balancer_certificate.test_certificate.name
#     certificate_ids                   = var.listener_ssl_configuration_certificate_ids
#     cipher_suite_name                 = var.listener_ssl_configuration_cipher_suite_name
#     protocols                         = var.listener_ssl_configuration_protocols
#     server_order_preference           = var.listener_ssl_configuration_server_order_preference
#     trusted_certificate_authority_ids = var.listener_ssl_configuration_trusted_certificate_authority_ids
#     verify_depth                      = var.listener_ssl_configuration_verify_depth
#     verify_peer_certificate           = var.listener_ssl_configuration_verify_peer_certificate
#   }
# }

# #create Backend set
# #routing_policy_name = oci_load_balancer_load_balancer_routing_policy.test_load_balancer_routing_policy.name
# #create ruleset

# variable "k3sserver-ILB_Listener_display_name-kubeapiserver" {
#   type    = string
#   default = "kubeapiserver"
# }

# variable "k3sserver-ILB_Listener_port-kubeapiserver" {
#   description = "Agents need to reach this port for registration to the cluster"
#   type        = number
#   default     = 6443
# }

# variable "k3sserver-ILB_Listener_protocol-kubeapiserver" {
#   description = "Agents need to reach this protocol for registration to the cluster"
#   type        = string
#   default     = "TCP"
# }

# variable "k3sserver-ILB_Listener_default_backend_set_name" {
#   description = "K3s Servers backend set"
#   type        = string
#   default     = "k3s server backends"
# }

# variable "k3sserver-ILB_Listener_connection_configuration" {
#   description = "TCP connection properties"
#   type        = map(any)
#   default = {
#     idle_timeout_in_seconds            = 30
#     backend_tcp_proxy_protocol_version = 2
#   }
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