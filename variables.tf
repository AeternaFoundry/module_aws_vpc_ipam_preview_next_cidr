variable "vpc_ipam_preview_next_cidrs" {
  description = <<EOT
Map of vpc_ipam_preview_next_cidrs, attributes below
Required:
    - ipam_pool_id
Optional:
    - disallowed_cidrs
    - netmask_length
    - region
EOT

  type = map(object({
    ipam_pool_id     = string
    disallowed_cidrs = optional(set(string))
    netmask_length   = optional(number)
    region           = optional(string)
  }))
  validation {
    condition = alltrue([
      for k, v in var.vpc_ipam_preview_next_cidrs : (
        v.netmask_length == null || (v.netmask_length >= 0 && v.netmask_length <= 32)
      )
    ])
    error_message = "must be between 0 and 32"
  }
  # Note: 1 additional provider-side validator is enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

