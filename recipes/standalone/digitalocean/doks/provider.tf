terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }

    rancher2 = {
      source  = "rancher/rancher2"
      version = "~> 4.2"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
  required_version = ">= 1.8.0"
}

provider "digitalocean" {
  token = var.do_token
}

provider "rancher2" {
  api_url    = var.rancher_url
  access_key = var.rancher_access_key
  secret_key = var.rancher_secret_key
  insecure   = true
}

provider "kubernetes" {
  config_path    = module.downstream_doks.kubeconfig_file
}