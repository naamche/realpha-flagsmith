data "aws_ssm_parameter" "common_database_url" {
  count = var.database_pooler_enabled ? 1 : 0

  name            = "${var.parameter_store_path_name}common/DATABASE_URL"
  with_decryption = true
}

locals {
  common_database_url_parts = var.database_pooler_enabled ? regex("^(.*@)([^/:]+):(\\d+)(/.*)$", data.aws_ssm_parameter.common_database_url[0].value) : []
  common_database_url       = var.database_pooler_enabled ? "${local.common_database_url_parts[0]}${var.database_pooler_host}:${var.database_pooler_port}${local.common_database_url_parts[3]}" : null
}

resource "aws_ssm_parameter" "common_database_url" {
  count = var.database_pooler_enabled ? 1 : 0

  name        = "${var.parameter_store_path_name}common/DATABASE_URL"
  description = "Flagsmith database URL"
  type        = "SecureString"
  value       = local.common_database_url
  overwrite   = true
}
