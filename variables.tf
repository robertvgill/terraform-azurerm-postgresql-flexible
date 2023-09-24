## resource group
variable "rg_resource_group_name" {
  description = "The name of the resource group in which to create the storage account."
  type        = string
  default     = null
}

variable "rg_location" {
  description = "Specifies the supported Azure location where the resource should be created."
  type        = string
  default     = null
}

## key vault
variable "akv_key_vault_name" {
  description = "The name of the Azure Key Vault for PostgreSQL."
  type        = string
}

## virtual network
variable "nw_virtual_network_name" {
  description = "The name of the Virtual Network."
  type        = string
  default     = null
}

variable "nw_vnet_subnet_pgf" {
  description = "The name of the subnet for PostgresSQL flexible."
  type        = string
}

## azure postgresql single
variable "psqlf_flexible_create" {
  description = "Controls if PostgreSQL Server should be created."
  type        = bool
  default     = false
}

variable "psqlf_database_create" {
  description = "Controls if PostgreSQL Database should be created."
  type        = bool
  default     = false
}

variable "psqlf_flexible_servers" {
  description = "For each postgresql, create an object that contain fields."
  default     = {}
}

variable "psqlf_flexible_config" {
  description = "PostgreSQL server configuration."
  type = object({
    version                       = string
    sku_name                      = string
    backup_retention_days         = number
    geo_redundant_backup_enabled  = bool
    create_mode                   = string
    storage_mb                    = number
  })
  default = null
}

variable "psqlf_private_dns_zone_name" {
  description = "The name of the Private DNS zone for PostgreSQL."
  default     = null
}

variable "psqlf_does_private_dns_zone_exist" {
  type        = bool
  default     = false
}

variable "psqlf_enable_private_endpoint" {
  description = "Manages a Private Endpoint to Azure database for PostgreSQL."
  default     = false
}

variable "psqlf_firewall_rules" {
  description = "Range of IP addresses to allow firewall connections."
  type = map(object({
    start_ip_address = string
    end_ip_address   = string
  }))
  default = null
}

variable "psqlf_key_vault_secret_admin_username" {
  description = "The name of the secret associated with the administrator login."
  default     = null  
}

variable "psqlf_key_vault_secret_admin_password" {
  description = "The name of the secret associated with the administrator password."
  default     = null  
}

variable "psqlf_subnet" {
  description = "For each subnet, create an object that contain fields."
  default     = {}
}

variable "psqlf_server_ha_mode" {
  type        = bool
  default     = false
}

variable "psqlf_use_availability_zone" {
  type        = bool
  default     = false
}

variable "psqlf_ignore_missing_vnet_service_endpoint" {
  description = "Should the Virtual Network Rule be created before the Subnet has the Virtual Network Service Endpoint enabled?"
  default     = false
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}