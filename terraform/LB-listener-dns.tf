#K3s Server Listeners
resource "oci_network_load_balancer_listener" "k3sserver-ILB_Listener_HTTPS6443" {
  default_backend_set_name = oci_network_load_balancer_backend_set.k3sserver-ILB-BackendSet_HTTPS6443.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3sserver-ILB.id
  name                     = var.k3sserver-ILB_Listeners.kubeapiserver.display_name
  port                     = var.k3sserver-ILB_Listeners.kubeapiserver.port
  protocol                 = var.k3sserver-ILB_Listeners.kubeapiserver.protocol
}



resource "oci_network_load_balancer_listener" "k3sserver-ILB_Listener_TCP10250" {
  default_backend_set_name = oci_network_load_balancer_backend_set.k3sserver-ILB-BackendSet_TCP10250.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3sserver-ILB.id
  name                     = var.k3sserver-ILB_Listeners.metrics.display_name
  port                     = var.k3sserver-ILB_Listeners.metrics.port
  protocol                 = var.k3sserver-ILB_Listeners.metrics.protocol
}

# resource "oci_network_load_balancer_listener" "k3sserver-ILB_Listener_UDP51820" {
#   default_backend_set_name = oci_network_load_balancer_backend_set.k3sserver-ILB-BackendSet_UDP51820.name
#   network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3sserver-ILB.id
#   name                     = var.k3sserver-ILB_Listeners.wireguardflannel.display_name
#   port                     = var.k3sserver-ILB_Listeners.wireguardflannel.port
#   protocol                 = var.k3sserver-ILB_Listeners.wireguardflannel.protocol
# }

#K3s Agent Listeners
# resource "oci_network_load_balancer_listener" "k3sagent-ILB_Listener_80" {
#   default_backend_set_name = oci_network_load_balancer_backend_set.k3sagent-ILB-BackendSet_HTTPS6443
#   network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3sagent-ILB.id
#   name                     = var.k3sagent-ILB_Listeners.https.display_name
#   port                     = var.k3sagent-ILB_Listeners.https.port
#   protocol                 = var.k3sagent-ILB_Listeners.https.protocol
# }

# resource "oci_network_load_balancer_listener" "k3sagent-ILB_Listener_443" {
#   default_backend_set_name = oci_network_load_balancer_backend_set.k3sagent-ILB-BackendSet.name
#   network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3sagent-ILB.id
#   name                     = var.k3sagent-ILB_Listeners.https.display_name
#   port                     = var.k3sagent-ILB_Listeners.https.port
#   protocol                 = var.k3sagent-ILB_Listeners.https.protocol
# }

resource "oci_network_load_balancer_listener" "k3sagent-ILB_Listener_HTTPS6443" {
  default_backend_set_name = oci_network_load_balancer_backend_set.k3sagent-ILB-BackendSet_HTTPS6443.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3sagent-ILB.id
  name                     = var.k3sagent-ILB_Listeners.kubeapiserver.display_name
  port                     = var.k3sagent-ILB_Listeners.kubeapiserver.port
  protocol                 = var.k3sagent-ILB_Listeners.kubeapiserver.protocol
}

# resource "oci_network_load_balancer_listener" "k3sagent-ILB_Listener_8472" {
#   default_backend_set_name = oci_network_load_balancer_backend_set.k3sagent-ILB-BackendSet_UDP8472.name
#   network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3sagent-ILB.id
#   name                     = var.k3sagent-ILB_Listeners.wireguardvxlan.display_name
#   port                     = var.k3sagent-ILB_Listeners.wireguardvxlan.port
#   protocol                 = var.k3sagent-ILB_Listeners.wireguardvxlan.protocol
# }

resource "oci_network_load_balancer_listener" "k3sagent-ILB_Listener_TCP10250" {
  default_backend_set_name = oci_network_load_balancer_backend_set.k3sagent-ILB-BackendSet_TCP10250.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3sagent-ILB.id
  name                     = var.k3sagent-ILB_Listeners.metrics.display_name
  port                     = var.k3sagent-ILB_Listeners.metrics.port
  protocol                 = var.k3sagent-ILB_Listeners.metrics.protocol
}

# resource "oci_network_load_balancer_listener" "k3sagent-ILB_Listener_UDP51820" {
#   default_backend_set_name = oci_network_load_balancer_backend_set.k3sagent-ILB-BackendSet_UDP51820.name
#   network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3sagent-ILB.id
#   name                     = var.k3sagent-ILB_Listeners.wireguardflannel.display_name
#   port                     = var.k3sagent-ILB_Listeners.wireguardflannel.port
#   protocol                 = var.k3sagent-ILB_Listeners.wireguardflannel.protocol
# }

#K3s DB Listeners
resource "oci_network_load_balancer_listener" "k3sdb-ILB_Listener_TCP5432" {
  default_backend_set_name = oci_network_load_balancer_backend_set.k3sdb-ILB-BackendSet_TCP5432.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3sdb-ILB.id
  name                     = var.k3sDB-ILB_Listeners.postgresql.display_name
  port                     = var.k3sDB-ILB_Listeners.postgresql.port
  protocol                 = var.k3sDB-ILB_Listeners.postgresql.protocol
}