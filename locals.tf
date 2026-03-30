locals {
  artifacthub_matrix = jsondecode(data.http.artifacthub_matrix.response_body)

  latest_helm_version = local.artifacthub_matrix.version
}