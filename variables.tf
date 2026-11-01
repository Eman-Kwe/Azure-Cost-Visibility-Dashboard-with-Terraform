variable "yourname" {
  description = "Short lowercase name used as a suffix in resource names"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "alert_email" {
  description = "Email address that receives budget alerts"
  type        = string
}

variable "budget_amount" {
  description = "Monthly budget in USD"
  type        = number
  default     = 200
}

variable "budget_start_date" {
  description = "First day of the current or a future month (RFC3339). Update before applying."
  type        = string
  default     = "2026-11-01T00:00:00Z"
}

variable "tags" {
  description = "Tags applied to all resources"
  type        = map(string)
  default = {
    project = "cost-dashboard"
    env     = "learning"
  }
}
