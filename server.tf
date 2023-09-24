## azure postgresql
resource "azurerm_postgresql_flexible_server" "apg" {
  for_each   = var.psqlf_flexible_servers

  depends_on = [
    data.azurerm_key_vault_secret.admin_username,
    data.azurerm_key_vault_secret.admin_password,
    azurerm_private_dns_zone.apgdz,
    azurerm_private_dns_zone_virtual_network_link.dzvlink,
    azurerm_subnet.psqlf,
  ]

  resource_group_name           = var.rg_resource_group_name
  location                      = var.rg_location

  name                          = each.value.name

  administrator_login           = data.azurerm_key_vault_secret.admin_username[0].value
  administrator_password        = data.azurerm_key_vault_secret.admin_password[0].value
  sku_name                      = var.psqlf_flexible_config.sku_name
  version                       = var.psqlf_flexible_config.version
  storage_mb                    = var.psqlf_flexible_config.storage_mb
  backup_retention_days         = var.psqlf_flexible_config.backup_retention_days
  geo_redundant_backup_enabled  = var.psqlf_flexible_config.geo_redundant_backup_enabled
  create_mode                   = var.psqlf_flexible_config.create_mode
  delegated_subnet_id           = azurerm_subnet.psqlf["psqlf"].id
  private_dns_zone_id           = var.psqlf_enable_private_endpoint ? azurerm_private_dns_zone.apgdz[0].id : data.azurerm_private_dns_zone.apgdz[0].id




  tags                         = merge({ "ResourceName" = format("%s", each.value.name) }, var.tags, )

  dynamic "high_availability" {
    for_each = var.psqlf_server_ha_mode ? [each.value.name] : []
    content {
      mode = "ZoneRedundant"
    }
  }

  lifecycle {
    ignore_changes = [
      delegated_subnet_id,
      zone,
    ]
  }
}