data "digitalocean_kubernetes_versions" "latest_kubernetes_version" {}

data "digitalocean_sizes" "droplet_size" {
  filter {
    key    = "slug"
    values = [var.node_pool_droplet_size]
  }
}

data "digitalocean_regions" "available_region" {
  filter {
    key    = "sizes"
    values = [element(data.digitalocean_sizes.droplet_size.sizes, 0).slug]
  }

  filter {
    key    = "available"
    values = ["true"]
  }

  filter {
    key    = "slug"
    values = [var.region]
  }

  sort {
    key       = "name"
    direction = "desc"
  }
}