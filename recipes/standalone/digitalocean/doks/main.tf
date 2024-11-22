module "downstream_doks" {
  source = "../../../../modules/distribution/doks"

  do_token               = var.do_token
  kubernetes_version     = data.digitalocean_kubernetes_versions.doks_versions.latest_version
  user_tag               = var.user_tag
  prefix                 = var.prefix
  labels                 = var.labels
  node_pool_count        = var.node_pool_count
  node_pool_droplet_size = var.node_pool_droplet_size
  region                 = var.region
  dependency             = [data.digitalocean_kubernetes_versions.doks_versions]
  create_ha_cluster      = true
  min_nodes              = var.min_nodes
  max_nodes              = var.max_nodes
}