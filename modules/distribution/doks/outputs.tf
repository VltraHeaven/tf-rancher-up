output "node_pool_droplet_size" {
  value = element(data.digitalocean_sizes.droplet_size.sizes, 0).slug
}

output "kubeconfig_file" {
  value = local.kc_file
}