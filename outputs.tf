output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "log_analytics_workspace_id" {
  value = azurerm_log_analytics_workspace.main.id
}

output "action_group_id" {
  value = azurerm_monitor_action_group.main.id
}

output "budget_name" {
  value = azurerm_consumption_budget_subscription.main.name
}

output "logic_app_name" {
  value = azurerm_logic_app_workflow.alert.name
}
