resource "helm_release" "sonar" {
  name       = "sonar"
  create_namespace = true
  namespace = "pipeline"
  repository = "https://SonarSource.github.io/helm-chart-sonarqube"
  chart      = "sonarqube"
  timeout    = 420

  values = [
    "${file("sonar-values.yml")}"
  ]
}

resource "kubernetes_storage_class" "sonar-sc" {
  metadata {
    name = "sonar-sc"
  }
  storage_provisioner = "ebs.csi.aws.com"
  volume_binding_mode = "Immediate"
  parameters = {
    type = "gp2"
  }
}

resource "kubernetes_storage_class" "sonar-sc2" {
  metadata {
    name = "sonar-sc2"
  }
  storage_provisioner = "ebs.csi.aws.com"
  volume_binding_mode = "Immediate"
  parameters = {
    type = "gp2"
  }
}

