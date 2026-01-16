variable "app_metadata" {
  description = <<EOF
Nullstone automatically injects metadata from the app module into this module through this variable.
This variable is a reserved variable for capabilities.
EOF

  type    = map(string)
  default = {}
}

locals {
  container_port = var.app_metadata["container_port"]
}

variable "initial_delay_seconds" {
  type        = number
  default     = 0
  description = <<EOF
Number of seconds after the container has started before startup, liveness or readiness probes are initiated.
If a startup probe is defined, liveness and readiness probe delays do not begin until the startup probe has succeeded.
In some older Kubernetes versions, the initialDelaySeconds might be ignored if periodSeconds was set to a value higher than initialDelaySeconds.
However, in current versions, initialDelaySeconds is always honored and the probe will not start until after this initial delay.
Defaults to 0 seconds.
Minimum value is 0.
EOF
}

variable "period_seconds" {
  type        = number
  default     = 10
  description = <<EOF
How often (in seconds) to perform the probe.
Default to 10 seconds.
The minimum value is 1. While a container is not Ready, the ReadinessProbe may be executed at times other than the configured periodSeconds interval.
This is to make the Pod ready faster.
EOF
}

variable "timeout_seconds" {
  type        = number
  default     = 1
  description = <<EOF
Number of seconds after which the probe times out.
Defaults to 1 second.
Minimum value is 1.
EOF
}

variable "success_threshold" {
  type        = number
  default     = 1
  description = <<EOF
Minimum consecutive successes for the probe to be considered successful after having failed.
Defaults to 1.
Must be 1 for liveness and startup Probes.
Minimum value is 1.
EOF
}

variable "failure_threshold" {
  type        = number
  default     = 3
  description = <<EOF
After a probe fails failureThreshold times in a row, Kubernetes considers that the overall check has failed: the container is not ready/healthy/live.
Defaults to 3.
Minimum value is 1.
For the case of a startup or liveness probe, if at least failureThreshold probes have failed, Kubernetes treats the container as unhealthy and triggers a restart for that specific container.
The kubelet honors the setting of terminationGracePeriodSeconds for that container.
For a failed readiness probe, the kubelet continues running the container that failed checks, and also continues to run more probes; because the check failed, the kubelet sets the Ready condition on the Pod to false.
EOF
}

variable "scheme" {
  type        = string
  default     = "HTTP"
  description = <<EOF
Scheme to use for connecting to the host (HTTP or HTTPS). Defaults to "HTTP".
EOF
}

variable "host" {
  type        = string
  default     = ""
  description = <<EOF
Host name to connect to, defaults to the pod IP. You probably want to set "Host" in httpHeaders instead.
EOF
}

variable "port" {
  type        = number
  default     = 0
  description = <<EOF
Number of the port to access on the container.
Number must be in the range 1 to 65535.
By default, this is set to 0 to use `container_port` on app.
EOF
}

variable "path" {
  type        = string
  default     = "/"
  description = <<EOF
Path to access on the HTTP server. Defaults to "/".
EOF
}

variable "http_headers" {
  type        = list(map(string))
  default     = []
  description = <<EOF
Custom headers to set in the request. HTTP allows repeated headers.
Example: `[ { name = "User-Agent", value = "startup-probe" }, ... ]`
EOF
}
