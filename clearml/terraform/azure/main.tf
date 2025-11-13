# main.tf — FULLY SELF-CONTAINED AZURE AKS TERRAFORM
# Uses ARM_* environment variables automatically (no tfvars needed)

terraform {
  required_version = ">= 1.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# --------------------------------------------------------------
# Optional variables – allow override via TF_VAR_... or tfvars
# But if ARM_* env vars are set, Terraform auto-uses them
# --------------------------------------------------------------
variable "arm_tenant_id" {
  type    = string
  default = null
}

variable "arm_client_id" {
  type    = string
  default = null
}

variable "arm_client_secret" {
  type      = string
  default   = null
  sensitive = true
}

variable "arm_subscription_id" {
  type    = string
  default = null
}

# --------------------------------------------------------------
# Provider – reads ARM_* env vars automatically
# --------------------------------------------------------------
provider "azurerm" {
  features {}

  # These are optional – only used if env vars are missing
  tenant_id       = var.arm_tenant_id
  client_id       = var.arm_client_id
  client_secret   = var.arm_client_secret
  subscription_id = var.arm_subscription_id
}

# -------------------------------
# Variables
# -------------------------------
variable "location"            { default = "eastus" }
variable "cluster_name"        { default = "clearml-dev" }
variable "kubernetes_version"  { default = "1.32" }
variable "worker_node_count"   { default = 2 }
variable "ssh_public_key"      { default = "~/.ssh/id_rsa.pub" }

# -------------------------------
# Resource Group
# -------------------------------
resource "azurerm_resource_group" "rg" {
  name     = "${var.cluster_name}-rg"
  location = var.location
}

# -------------------------------
# VNet + Subnet
# -------------------------------
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.cluster_name}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "aks_subnet" {
  name                 = "${var.cluster_name}-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# -------------------------------
# NSG: Allow SSH (22)
# -------------------------------
resource "azurerm_network_security_group" "nsg" {
  name                = "${var.cluster_name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  subnet_id                 = azurerm_subnet.aks_subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# -------------------------------
# AKS Cluster
# -------------------------------
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.cluster_name
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name                = "default"
    node_count          = var.worker_node_count
    vm_size             = "Standard_B4ms"  # 4 vCPU, 16 GB RAM
    vnet_subnet_id      = azurerm_subnet.aks_subnet.id
    os_disk_size_gb     = 64
  }

  identity {
    type = "SystemAssigned"
  }

  linux_profile {
    admin_username = "azureuser"
    ssh_key {
      key_data = file(var.ssh_public_key)
    }
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    service_cidr      = "172.16.0.0/16"
    dns_service_ip    = "172.16.0.10"
  }
}

# -------------------------------
# Outputs
# -------------------------------
output "kubeconfig" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}

output "cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "resource_group" {
  value = azurerm_resource_group.rg.name
}
