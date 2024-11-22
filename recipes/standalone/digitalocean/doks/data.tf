data "digitalocean_kubernetes_versions" "doks_versions" {
  version_prefix = var.kubernetes_version_prefix
}
