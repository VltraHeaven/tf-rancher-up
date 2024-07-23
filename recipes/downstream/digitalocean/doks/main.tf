locals {
  manifests = provider::kubernetes::manifest_decode_multi(data.http.registration_yaml.response_body)
}

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
}

resource "rancher2_cluster" "doks_imported" {
  name        = module.downstream_doks.cluster_name
  description = "DOKS Imported Cluster"
  depends_on = [ module.downstream_doks ]
}

# A bug in how Rancher generates registration manifests breaks the code below.
# Leaving this commented out until a PR fixing the issue is merged.
#resource "kubernetes_manifest" "registration_manifests" {
#  for_each = {
#    for manifest in local.manifests :
#    "${manifest.kind}--${manifest.metadata.name}" => manifest
#  }
#
#  manifest = each.value
#  depends_on = [ local.manifests ]
#  field_manager {
#    force_conflicts = true
#  }
#  computed_fields = ["metadata.namespace"]
#  depends_on = [ "module.downstream_doks", "rancher2_cluster.doks_imported"]
#}