resource "helm_release" "argocd" {
  repository = "https://charts.bitnami.com/bitnami"
  name = "argo-cd"
  chart = "argo-cd"
  namespace = kubernetes_namespace.argocd.metadata.0.name
  version = "4.7.2"

  set {
    name = "controller.replicaCount"
    value = 2
  }

  set {
    name = "server.metrics.enabled"
    value = true
  }

  set {
    name = "server.service.type"
    value = "NodePort"
  }
  set {
    name = "server.admin.password"
    value = "Fwfwr333423"
  }

  set {
    name  = "server.knownHosts"
    value = "bitbucket.org ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDQeJzhupRu0u0cdegZIa8e86EG2qOCsIsD1Xw0xSeiPDlCr7kq97NLmMbpKTX6Esc30NuoqEEHCuc7yWtwp8dI76EEEB1VqY9QJq6vk+aySyboD5QF61I/1WeTwu+deCbgKMGbUijeXhtfbxSxm6JwGrXrhBdofTsbKRUsrN1WoNgUa8uqN1Vx6WAJw1JHPhglEGGHea6QICwJOAr/6mrui/oB7pkaWKHj3z7d1IC4KWLtY47elvjbaTlkN04Kc/5LFEirorGYVbt15kAUlqGM65pk6ZBxtaO3+30LVlORZkxOh+LKL/BvbZ/iRNhItLqNyieoQj/uh/7Iv4uyH/cV/0b4WDSd3DptigWq84lJubb9t/DnZlrJazxyDCulTmKdOR7vs9gMTo+uoIrPSb8ScTtvw65+odKAlBj59dhnVp9zd7QUojOpXlL62Aw56U4oO+FALuevvMjiWeavKhJqlR7i5n9srYcrNV7ttmDw7kf/97P5zauIhxcjX+xHv4M="
  }
  set {
    name = "redis.enabled"
    value = false
  }

}