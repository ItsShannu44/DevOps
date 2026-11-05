variable "resource_name" {
  description = "Base resource name (srn-firstname pattern)"
  type        = string
  default     = "srn-197-shanmukha"
}

variable "location" {
  description = "Azure region to deploy resources into"
  type        = string
  default     = "centralindia"
}

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "rg-srn-197-shanmukha"
}

variable "key_vault_sku" {
  description = "SKU for the Azure Key Vault"
  type        = string
  default     = "standard"
}

variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default = {
    Project     = "srn-197-shanmukha"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}
