variable "do_token" {
  type        = string
  description = "DigitalOcean Authentication Token"
  default     = null
  sensitive   = true
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

variable "region" {
  type        = string
  description = "Target region for cluster deployment"
  default     = "sfo3"
}