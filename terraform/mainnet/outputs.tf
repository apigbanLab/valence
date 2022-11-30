# Export Terraform variable values to an Ansible var_file
resource "local_file" "tf_one_AnsibleInventory" {
  content = templatefile("inventory.tmpl",
    {
      server-name         = oci_core_instance.public.display_name
      server-private-ipv4 = oci_core_instance.public.private_ip
      server-public-ipv4  = oci_core_instance.public.public_ip

      server-disk-id   = oci_core_volume.disk-one.id
      server-disk-name = oci_core_volume.disk-one.display_name

    }

  )
  filename = "../../server-config/host_vars/one.yaml"
}