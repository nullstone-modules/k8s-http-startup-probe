output "readiness_probes" {
  value = [
    {
      initial_delay_seconds = var.initial_delay_seconds
      period_seconds        = var.period_seconds
      timeout_seconds       = var.timeout_seconds
      success_threshold     = var.success_threshold
      failure_threshold     = var.failure_threshold

      http_get = jsonencode({
        scheme       = var.scheme == "" ? null : var.scheme
        host         = var.host == "" ? null : var.host
        path         = var.path
        port         = var.port == 0 ? local.container_port : var.port
        http_headers = var.http_headers
      })
    }
  ]
}
