resource "kind_cluster" "flux" {
  name            = "flux"
  wait_for_ready  = true
  kubeconfig_path = "../kubeconfig.yaml"

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    node {
      role = "control-plane"

      kubeadm_config_patches = [
        jsonencode({
          kind : "InitConfiguration",
          nodeRegistration : {
            kubeletExtraArgs : {
              node-labels : "ingress-ready=true",
            },
          },
        }),
      ]

      extra_port_mappings {
        container_port = 80
        host_port      = 80
      }

      extra_port_mappings {
        container_port = 443
        host_port      = 443
      }
    }

    dynamic "node" {
      for_each = range(var.worker_count)

      content {
        role = "worker"
      }
    }
  }
}
