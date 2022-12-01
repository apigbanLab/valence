resource "oci_core_security_list" "public" {
  compartment_id = var.provider_compartment_id
  display_name   = var.provider_label_prefix == "none" ? "public" : "${var.provider_label_prefix}-public"

  egress_security_rules {
    protocol    = local.all_protocols
    destination = local.anywhere
  }

  dynamic "ingress_security_rules" {
    # allow ssh

    for_each = var.sec_public_access
    iterator = sec_public_access_iterator
    content {
      protocol = local.tcp_protocol
      source   = sec_public_access_iterator.value == "anywhere" ? local.anywhere : sec_public_access_iterator.value

      tcp_options {
        min = local.ssh_port
        max = local.ssh_port
      }
    }
  }

  dynamic "ingress_security_rules" {
    # allow wireguard udp

    for_each = var.sec_wireguard_access
    iterator = wireguard_access_iterator
    content {
      protocol = local.udp_protocol
      source   = wireguard_access_iterator.value == "anywhere" ? local.anywhere : wireguard_access_iterator.value

      udp_options {
        min = local.wireguard_port
        max = local.wireguard_port
      }
    }
  }

  ingress_security_rules {
    description = "allow ICMP"
    protocol    = local.icmp_protocol
    source      = local.anywhere
  }

  vcn_id = module.vcn.vcn_id
}