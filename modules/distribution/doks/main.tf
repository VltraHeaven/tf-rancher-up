locals {
  node_pool_count = var.node_pool_count > 1 ? "${var.node_pool_count - 1}" : 0
}

resource "digitalocean_kubernetes_cluster" "auto_upgrading_cluster" {
  name         = "${var.prefix}-${var.tag_begin}"
  region       = data.digitalocean_regions.available_region.regions.0.slug
  auto_upgrade = true
  version      = data.digitalocean_kubernetes_versions.doks_versions.latest_version
  ha           = false

  maintenance_policy {
    start_time = "04:00"
    day        = "sunday"
  }

  node_pool {
    name       = "${var.prefix}-node-pool-1"
    size       = element(data.digitalocean_sizes.droplet_size.sizes, 0).slug 
    auto_scale = true
    min_nodes  = 1
    max_nodes  = 5
    tags       = ["user:${var.user_tag}", "creator:${var.prefix}"]
    labels     = var.labels
  }
}

resource "digitalocean_kubernetes_node_pool" "autoscaling-pool" {
  count      = local.node_pool_count
  cluster_id = digitalocean_kubernetes_cluster.auto_upgrading_cluster.id
  name       = "${var.prefix}-node-pool-${count.index + var.tag_begin + 1}"
  size       = element(data.digitalocean_sizes.droplet_size.sizes, 0).slug 
  auto_scale = true
  min_nodes  = 1
  max_nodes  = 5
  tags       = ["user:${var.user_tag}", "creator:${var.prefix}"]
  labels     = var.labels
}

resource "local_file" "kube_config" {
  content         = digitalocean_kubernetes_cluster.auto_upgrading_cluster.kube_config.0.raw_config
  filename        = "./doks_kube_config.yaml"
  file_permission = "0600"
}