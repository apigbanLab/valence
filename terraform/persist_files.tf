resource "oci_objectstorage_object" "privkey_upload" {
    bucket = "terraformstate"
    source = "${path.cwd}/oci.privkey"
    namespace = "axafm68tcvts"
    object = "valence/oci.privkey"
}