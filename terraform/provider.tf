terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 4.0.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.4"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "2.2.0"
    }
  }
  required_version = ">=v1.3.0"
}

provider "oci" {
  fingerprint      = var.provider_api_fingerprint
  private_key_path = var.provider_api_private_key_path
  region           = var.provider_region
  tenancy_ocid     = var.provider_tenancy_id
  user_ocid        = var.provider_user_id
}

# provider identity parameters
variable "provider_api_fingerprint" {
  description = "fingerprint of oci api private key"
  type        = string
}

variable "provider_api_private_key_path" {
  description = "path to oci api private key used"
  type        = string
}

variable "provider_tenancy_id" {
  description = "tenancy id where to create the sources"
  type        = string
}

variable "provider_user_id" {
  description = "id of user that terraform will use to create the resources"
  type        = string
}

variable "provider_region" {
  description = "region"
  type        = string
  default     = "me-dubai-1"
}