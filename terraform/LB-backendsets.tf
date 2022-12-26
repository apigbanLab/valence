#K3s Server Backend Sets
resource "oci_network_load_balancer_backend_set" "k3sserver-ILB-BackendSet_HTTPS6443" {
  health_checker {
    protocol           = var.k3sserver-ILB_Listeners.kubeapiserver.be_healthcheck_protocol
    interval_in_millis = 10000
    port               = var.k3sserver-ILB_Listeners.kubeapiserver.port
    retries            = 3
    return_code        = 200
    timeout_in_millis  = 2000
    url_path           = "/ping"
  }
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3sserver-ILB.id
  name                     = var.k3sserver-ILB_Listeners.kubeapiserver.display_name
  policy                   = var.k3sserver-ILB_BackendSet_policy
}

resource "oci_network_load_balancer_backend_set" "k3sserver-ILB-BackendSet_UDP8472" {
  health_checker {
    protocol           = var.k3sserver-ILB_Listeners.wireguardvxlan.protocol
    interval_in_millis = 10000
    port               = var.k3sserver-ILB_Listeners.wireguardvxlan.port
    retries            = 3
    timeout_in_millis  = 2000
  }
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3sserver-ILB.id
  name                     = var.k3sserver-ILB_Listeners.wireguardvxlan.display_name
  policy                   = var.k3sserver-ILB_BackendSet_policy
}

resource "oci_network_load_balancer_backend_set" "k3sserver-ILB-BackendSet_TCP10250" {
  health_checker {
    protocol           = var.k3sserver-ILB_Listeners.metrics.protocol
    interval_in_millis = 10000
    port               = var.k3sserver-ILB_Listeners.metrics.port
    retries            = 3
    timeout_in_millis  = 2000
  }
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3sserver-ILB.id
  name                     = var.k3sserver-ILB_Listeners.metrics.display_name
  policy                   = var.k3sserver-ILB_BackendSet_policy
}

resource "oci_network_load_balancer_backend_set" "k3sserver-ILB-BackendSet_UDP51820" {
  health_checker {
    protocol           = var.k3sserver-ILB_Listeners.wireguardflannel.protocol
    interval_in_millis = 10000
    port               = var.k3sserver-ILB_Listeners.wireguardflannel.port
    retries            = 3
    timeout_in_millis  = 2000
  }
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3sserver-ILB.id
  name                     = var.k3sserver-ILB_Listeners.wireguardflannel.display_name
  policy                   = var.k3sserver-ILB_BackendSet_policy
}

#K3s Agent Backend Sets
resource "oci_network_load_balancer_backend_set" "k3sagent-ILB-BackendSet_HTTPS6443" {
  health_checker {
    protocol           = var.k3sagent-ILB_Listeners.kubeapiserver.be_healthcheck_protocol
    interval_in_millis = 10000
    port               = var.k3sagent-ILB_Listeners.kubeapiserver.port
    retries            = 3
    return_code        = 200
    timeout_in_millis  = 2000
    url_path           = "/ping"
  }
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3sagent-ILB.id
  name                     = var.k3sagent-ILB_Listeners.kubeapiserver.display_name
  policy                   = var.k3sagent-ILB_BackendSet_policy
}

resource "oci_network_load_balancer_backend_set" "k3sagent-ILB-BackendSet_UDP51820" {
  health_checker {
    protocol           = var.k3sagent-ILB_Listeners.wireguardflannel.protocol
    interval_in_millis = 10000
    port               = var.k3sagent-ILB_Listeners.wireguardflannel.port
    retries            = 3
    timeout_in_millis  = 2000
  }
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3sagent-ILB.id
  name                     = var.k3sagent-ILB_Listeners.wireguardflannel.display_name
  policy                   = var.k3sagent-ILB_BackendSet_policy
}

resource "oci_network_load_balancer_backend_set" "k3sagent-ILB-BackendSet_UDP8472" {
  health_checker {
    protocol           = var.k3sagent-ILB_Listeners.wireguardvxlan.protocol
    interval_in_millis = 10000
    port               = var.k3sagent-ILB_Listeners.wireguardvxlan.port
    retries            = 3
    timeout_in_millis  = 2000
  }
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3sagent-ILB.id
  name                     = var.k3sagent-ILB_Listeners.wireguardvxlan.display_name
  policy                   = var.k3sagent-ILB_BackendSet_policy
}

resource "oci_network_load_balancer_backend_set" "k3sagent-ILB-BackendSet_TCP10250" {
  health_checker {
    protocol           = var.k3sagent-ILB_Listeners.metrics.protocol
    interval_in_millis = 10000
    port               = var.k3sagent-ILB_Listeners.metrics.port
    retries            = 3
    timeout_in_millis  = 2000
  }
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3sagent-ILB.id
  name                     = var.k3sagent-ILB_Listeners.metrics.display_name
  policy                   = var.k3sagent-ILB_BackendSet_policy
}

#K3s Agent Backend Sets
resource "oci_network_load_balancer_backend_set" "k3sdb-ILB-BackendSet_TCP5432" {
  health_checker {
    protocol           = var.k3sDB-ILB_Listeners.postgresql.protocol
    interval_in_millis = 10000
    port               = var.k3sDB-ILB_Listeners.postgresql.port
    retries            = 3
    timeout_in_millis  = 2000
  }
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3sdb-ILB.id
  name                     = var.k3sDB-ILB_Listeners.postgresql.display_name
  policy                   = var.k3sdb-ILB_BackendSet_policy
}