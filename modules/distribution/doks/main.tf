locals {
  node_pool_count = var.node_pool_count > 1 ? "${var.node_pool_count - 1}" : 0
  kc_path         = var.kube_config_path != null ? var.kube_config_path : path.cwd
  kc_file         = var.kube_config_filename != null ? "${local.kc_path}/${var.kube_config_filename}" : "${local.kc_path}/${var.prefix}_kube_config.yml"
  kc_file_backup  = "${local.kc_file}.backup"
}


resource "digitalocean_kubernetes_cluster" "cluster" {
  name                             = "${var.prefix}-${var.tag_begin}"
  region                           = data.digitalocean_regions.available_region.regions.0.slug
  auto_upgrade                     = var.automatic_upgrades
  version                          = data.digitalocean_kubernetes_versions.doks_versions.latest_version
  ha                               = var.create_ha_cluster
  surge_upgrade                    = var.enable_surge_upgrades
  destroy_all_associated_resources = var.destroy_digitalocean_resources

  maintenance_policy {
    start_time = var.automatic_upgrade_time
    day        = var.automatic_upgrade_day
  }

  node_pool {
    name       = "${var.prefix}-node-pool-1"
    size       = element(data.digitalocean_sizes.droplet_size.sizes, 0).slug
    auto_scale = true
    min_nodes  = var.min_nodes
    max_nodes  = var.max_nodes
    tags       = ["user:${var.user_tag}", "creator:${var.prefix}"]
    labels     = var.labels
  }
}

resource "digitalocean_kubernetes_node_pool" "autoscaling-pool" {
  count      = local.node_pool_count
  cluster_id = digitalocean_kubernetes_cluster.cluster.id
  name       = "${var.prefix}-node-pool-${count.index + var.tag_begin + 1}"
  size       = element(data.digitalocean_sizes.droplet_size.sizes, 0).slug
  auto_scale = true
  min_nodes  = var.min_nodes
  max_nodes  = var.max_nodes
  tags       = ["user:${var.user_tag}", "creator:${var.prefix}"]
  labels     = var.labels
}

resource "local_file" "kube_config_yaml" {
  count           = var.create_kubeconfig_file ? 1 : 0
  content         = digitalocean_kubernetes_cluster.cluster.kube_config.0.raw_config
  filename        = local.kc_file
  file_permission = "0600"
}

resource "local_file" "kube_config_yaml_backup" {
  count           = var.create_kubeconfig_file ? 1 : 0
  content         = digitalocean_kubernetes_cluster.cluster.kube_config.0.raw_config
  filename        = local.kc_file
  file_permission = "0600"
}
