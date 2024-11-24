resource "null_resource" "apply_local_path_storage" {
  provisioner "local-exec" {
    command = "kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml"
  }
}

resource "null_resource" "patch_local_path_storageclass" {
  provisioner "local-exec" {
    command = "kubectl patch storageclass local-path -p '{\"metadata\": {\"annotations\":{\"storageclass.kubernetes.io/is-default-class\":\"true\"}}}'"
  }

  depends_on = [null_resource.apply_local_path_storage]
}

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

resource "kubernetes_namespace" "logging" {
  metadata {
    name = "logging"
  }
}

resource "kubernetes_namespace" "kafka" {
  metadata {
    name = "kafka"
  }
}

resource "kubernetes_namespace" "database" {
  metadata {
    name = "database"
  }
}

resource "kubernetes_namespace" "coinpay" {
  metadata {
    name = "coinpay"
  }
}

