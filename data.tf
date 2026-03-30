data "http" "artifacthub_matrix" {
  url = "https://artifacthub.io/api/v1/packages/helm/ananace-charts/matrix-synapse?json"

  request_headers = {
    Accept = "application/json"
  }
}