resource "oci_autoscaling_auto_scaling_configuration" "k3sserver-ASC" {
  #Required
  auto_scaling_resources {
    #Required
    id   = oci_core_instance_pool.IP-k3sserver.id
    type = var.k3sserver-ASC_target_type
  }
  compartment_id = var.provider_compartment_id
  policies {
    policy_type = var.k3sserver-ASC_policies_policy_type
    capacity {
      initial = var.k3sserver-ASC_policies_capacity_initial
      max     = var.k3sserver-ASC_policies_capacity_max
      min     = var.k3sserver-ASC_policies_capacity_min
    }
    display_name = var.k3sserver-ASC_policies_rules_display_name
    is_enabled   = true
    rules {
      action {
        type  = "CHANGE_COUNT_BY"
        value = "-1"
      }
      display_name = "k3s-scale_down_CPU_LTE60_500s"
      metric {
        metric_type = "CPU_UTILIZATION"
        threshold {
          operator = "LT"
          value    = "60"
        }
      }
    }
    rules {
      action {
        type  = "CHANGE_COUNT_BY"
        value = "1"
      }
      display_name = "k3s-scale_down_CPU_GTE80_300s"
      metric {
        metric_type = "CPU_UTILIZATION"
        threshold {
          operator = "GT"
          value    = "80"
        }
      }
    }
  }

  display_name = var.k3sserver-ASC_policies_display_name
  is_enabled   = true
}