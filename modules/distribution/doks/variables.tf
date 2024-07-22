variable "do_token" {
  type        = string
  description = "DigitalOcean Authentication Token"
  default     = null
  sensitive   = true
}

variable "kubernetes_version" {
  type        = string
  description = "The major and minor release version of the new cluster. A cluster may only be upgraded to newer versions in-place. If the version is decreased, a new resource will be created."
  default     = "1.28"
  nullable    = false
}

variable "user_tag" {
  type        = string
  description = "FirstInitialLastname of user"
  nullable    = false
}

variable "prefix" {
  type        = string
  description = "Prefix added to names of all resources"
  default     = "rancher-doks-terraform"
  nullable    = false
}

variable "tag_begin" {
  type        = number
  description = "Tag from this number when module is called more than once"
  default     = 1
}

variable "labels" {
  type        = map(string)
  description = "A map of key/value pairs to apply to nodes in the nodepool"
  default = null
}

variable "node_pool_count" {
  type        = number
  description = "Number of node pools to create"
  default     = 1
  nullable    = false
}

variable "node_pool_droplet_size" {
  type        = string
  description = "Node Pool's droplet size"
  default     = "s-2vcpu-4gb"
  nullable    = false
}

variable "min_nodes" {
  type        = number
  description = "Minimum amount of nodes per node pool"
  default     = 1
}

variable "max_nodes" {
  type        = number
  description = "Minimum amount of nodes per node pool"
  default     = 5
}
variable "region" {
  type        = string
  description = "Target region for cluster deployment"
  default     = "sfo3"
}

variable "automatic_upgrades" {
  type        = bool
  description = "Enable automatic patch upgrades for the managed cluster"
  default     = false
}

variable "automatic_upgrade_time" {
  type        = string
  description = "Set what time automatic upgrades will take place"
  default     = "04:00"
}

variable "automatic_upgrade_day" {
  type        = string
  description = "Set which day automatic upgrades will take place"
  default     = "sunday"
}

variable "create_ha_cluster" {
  type        = bool
  description = "Create a high-availablity managed cluster"
  default     = false
}

variable "enable_surge_upgrades" {
  type        = bool
  description = "Reduce upgrade times by creating duplicate nodes during cluster upgrades"
  default     = true
}

variable "create_kubeconfig_file" {
  description = "Boolean flag to generate a kubeconfig file (mostly used for dev only)"
  default     = true
}

variable "kube_config_path" {
  description = "The path to write the kubeconfig for the RKE cluster"
  type        = string
  default     = null
}

variable "kube_config_filename" {
  description = "Filename to write the kube config"
  type        = string
  default     = null
}

variable "destroy_digitalocean_resources" {
  type = bool
  default = true
  description = "Destroy all associated DigitalOcean resources created via the Kubernetes API when the cluster is destroyed"
}