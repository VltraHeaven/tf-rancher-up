output "cluster_name" {
  value = module.downstream_doks.cluster_name
}

output "insecure_registration_command" {
  value = data.rancher2_cluster.doks_imported.cluster_registration_token[0].insecure_command
}

output "registration_command" {
  value = data.rancher2_cluster.doks_imported.cluster_registration_token[0].command
}