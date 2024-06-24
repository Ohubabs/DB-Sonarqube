#resource "kubernetes_ingress_v1" "jenkins1" {
#  wait_for_load_balancer = true
#  metadata {
#    name = "jenkins1"
#    namespace = "pipeline"
#    annotations = {
#        "alb.ingress.kubernetes.io/load-balancer-name" = "jenkins"
#        "alb.ingress.kubernetes.io/scheme"             = "internet-facing"
#        "alb.ingress.kubernetes.io/target-type"        = "ip" 
#        "alb.ingress.kubernetes.io/backend-protocol"   = "HTTPS"
#        "alb.ingress.kubernetes.io/certificate-arn" = var.acm
#  }
#  }
#  spec {
#    ingress_class_name = "alb"
#    default_backend {
#      service {
#        name = "jenkins"
#        port {
#          number = 443 #8080 changed on 04/09/24
#        }
#      }
#    }
#    rule {
#      host = "jenkins.devopsnetwork.net"  
#      http {
#        path {
#          path = "/"
#          path_type = "Exact"
#          backend {
#            service {
#              name = "jenkins"
#              port {
#                number = 443 #8080
#              }
#            }
#          }
#        }
#      }
#    }
#  }
#}

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
      hosts = ["pipeline.devopsnetwork.net"] 
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
