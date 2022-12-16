
# Rules related to k3s-server-subnet-nsg
# EGRESS
resource "oci_core_network_security_group_security_rule" "k3s-server_nsg_Egress" {
  #checkov:skip=CKV_OCI_21: Stateful rules are applied
  network_security_group_id = oci_core_network_security_group.k3s-server_nsg.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
}

# INGRESS
resource "oci_core_network_security_group_security_rule" "k3s-server_nsg_Ingress_tcpAll" {
  #checkov:skip=CKV_OCI_21: Stateful rules are applied
  network_security_group_id = oci_core_network_security_group.k3s-server_nsg.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = var.workstation_publicIPAddress
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 65535
      min = 1
    }
  }
}

resource "oci_core_network_security_group_security_rule" "k3s-server_nsg_Ingress_kubeapiserver" {
  #checkov:skip=CKV_OCI_21: Stateful rules are applied
  network_security_group_id = oci_core_network_security_group.k3s-server_nsg.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = oci_core_network_security_group.k3s-agent_nsg.id
  source_type               = "NETWORK_SECURITY_GROUP"
  tcp_options {
    destination_port_range {
      max = 6443
      min = 6443
    }
  }
}

resource "oci_core_network_security_group_security_rule" "k3s-server_nsg_Ingress_metricsServer" {
  #checkov:skip=CKV_OCI_21: Stateful rules are applied
  network_security_group_id = oci_core_network_security_group.k3s-server_nsg.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "10.0.0.0/8"
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 10250
      min = 10250
    }
  }
}

resource "oci_core_network_security_group_security_rule" "k3s-server_nsg_Ingress_wireguardFlannel" {
  #checkov:skip=CKV_OCI_21: Stateful rules are applied
  network_security_group_id = oci_core_network_security_group.k3s-server_nsg.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "10.0.0.0/8"
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 51820
      min = 51820
    }
  }
}

resource "oci_core_network_security_group_security_rule" "k3s-server_nsg_Ingress_wireguardVxlan" {
  #checkov:skip=CKV_OCI_21: Stateful rules are applied
  network_security_group_id = oci_core_network_security_group.k3s-server_nsg.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "10.0.0.0/8"
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 8472
      min = 8472
    }
  }
}

# Rules related to k3s-db-subnet-nsg
# EGRESS
resource "oci_core_network_security_group_security_rule" "k3s-db_nsg_Egress" {
  #checkov:skip=CKV_OCI_21: Stateful rules are applied
  network_security_group_id = oci_core_network_security_group.k3s-db_nsg.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
}


# INGRESS
resource "oci_core_network_security_group_security_rule" "k3s-db_nsg_Ingress_tcpAll" {
  #checkov:skip=CKV_OCI_21: Stateful rules are applied
  network_security_group_id = oci_core_network_security_group.k3s-db_nsg.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = var.workstation_publicIPAddress
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 65535
      min = 1
    }
  }
}

resource "oci_core_network_security_group_security_rule" "k3s-db_nsg_Ingress_postgresql" {
  #checkov:skip=CKV_OCI_21: Stateful rules are applied
  network_security_group_id = oci_core_network_security_group.k3s-db_nsg.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = oci_core_network_security_group.k3s-server_nsg.id
  source_type               = "NETWORK_SECURITY_GROUP"
  tcp_options {
    destination_port_range {
      max = 5432
      min = 5432
    }
  }
}

# Rules related to k3s-agent-subnet-nsg
# EGRESS
resource "oci_core_network_security_group_security_rule" "k3s-agent_nsg_Egress" {
  #checkov:skip=CKV_OCI_21: Stateful rules are applied
  network_security_group_id = oci_core_network_security_group.k3s-agent_nsg.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
}

# INGRESS

resource "oci_core_network_security_group_security_rule" "k3s-agent_nsg_Ingress_tcpAll" {
  #checkov:skip=CKV_OCI_21: Stateful rules are applied
  network_security_group_id = oci_core_network_security_group.k3s-agent_nsg.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = var.workstation_publicIPAddress
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 65535
      min = 1
    }
  }
}

resource "oci_core_network_security_group_security_rule" "k3s-agent_nsg_Ingress_kubeapiServer" {
  #checkov:skip=CKV_OCI_21: Stateful rules are applied
  network_security_group_id = oci_core_network_security_group.k3s-agent_nsg.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = oci_core_network_security_group.k3s-server_nsg.id
  source_type               = "NETWORK_SECURITY_GROUP"
  tcp_options {
    destination_port_range {
      max = 5432
      min = 5432
    }
  }
}

resource "oci_core_network_security_group_security_rule" "k3s-agent_nsg_Ingress_metricsServer" {
  #checkov:skip=CKV_OCI_21: Stateful rules are applied
  network_security_group_id = oci_core_network_security_group.k3s-agent_nsg.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "10.0.0.0/8"
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 10250
      min = 10250
    }
  }
}

resource "oci_core_network_security_group_security_rule" "k3s-agent_nsg_Ingress_nodePortServices" {
  #checkov:skip=CKV_OCI_21: Stateful rules are applied
  network_security_group_id = oci_core_network_security_group.k3s-agent_nsg.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "10.0.0.0/8"
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 32767
      min = 30000
    }
  }
}

resource "oci_core_network_security_group_security_rule" "k3s-agent_nsg_Ingress_wireguardVxlan" {
  #checkov:skip=CKV_OCI_21: Stateful rules are applied
  network_security_group_id = oci_core_network_security_group.k3s-agent_nsg.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "10.0.0.0/8"
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 8472
      min = 8472
    }
  }
}

resource "oci_core_network_security_group_security_rule" "k3s-agent_nsg_Ingress_wireguardFlannel" {
  #checkov:skip=CKV_OCI_21: Stateful rules are applied
  network_security_group_id = oci_core_network_security_group.k3s-agent_nsg.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "10.0.0.0/8"
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 51820
      min = 51820
    }
  }
}