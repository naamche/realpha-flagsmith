locals {
  flagsmith_database_url_parts = var.enable_shared_pooler_database_url ? regex(
    "^([^@]+@)[^/:?]+(:[0-9]+)?(/.*)$",
    data.aws_ssm_parameter.current_flagsmith_database_url[0].value,
  ) : []

  flagsmith_database_url = var.enable_shared_pooler_database_url ? format(
    "%s%s:%d%s",
    local.flagsmith_database_url_parts[0],
    nonsensitive(data.aws_ssm_parameter.shared_privatelink_nlb_dns_name[0].value),
    var.postgres_pooler_port,
    local.flagsmith_database_url_parts[2],
  ) : ""
}

resource "aws_ssm_parameter" "flagsmith_database_url" {
  count = var.enable_shared_pooler_database_url ? 1 : 0

  name        = "${var.parameter_store_path_name}common/DATABASE_URL"
  description = "Flagsmith database URL routed through the shared reAlpha PgBouncer listener."
  type        = "SecureString"
  value       = local.flagsmith_database_url
  overwrite   = true
}
