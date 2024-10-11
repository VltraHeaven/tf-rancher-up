data "digitalocean_kubernetes_versions" "doks_versions" {
  version_prefix = var.kubernetes_version_prefix
}

data "rancher2_cluster" "doks_imported" {
  name = rancher2_cluster.doks_imported.name
}

data "http" "registration_yaml" {
  url      = data.rancher2_cluster.doks_imported.cluster_registration_token[0].manifest_url
  insecure = true
}

