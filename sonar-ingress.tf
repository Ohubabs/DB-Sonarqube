## Expose Sonarqube to the internet securely

resource "kubernetes_ingress_v1" "sonarqube-ingress" {
  wait_for_load_balancer = true
  metadata {
    name = "sonarqube-ingress"
    namespace = "pipeline"
    annotations = {
        "cert-manager.io/cluster-issuer" = "pipeline-issuer"
  }
  }
  spec {
    ingress_class_name = "nginx"
    tls {
      secret_name = "sonar-secret"
      hosts = ["qa.devopsnetwork.net"] 
    }
    rule {
      host = "qa.devopsnetwork.net"  
      http {
        path {
          path = "/"
          backend {
            service {
              name = "sonar-sonarqube"
              port {
                number = 443 #9000
              }
            }
          }
        }
      }
    }
  }
}
