# How to deploy

1. Deploy namespaces (see: namespaces.yml)
1. Deploy middlewares
    * postgresql (see: helm/postgresql/values.yml)
    * cert-manager (see: helm/cert-manager/*.yml, and cert/wildcard-vue-practice-work.yml)
1. Deploy secrets
    * for vue-practice (see: secret/vue-practice.yml)
1. Deploy applications
    * vue-practice (see: vue-practice/deployment.yml)
1. Deploy networks settings
    * for vue-practice (see: vue-practice/service.yml)
    * ingress (see: ingress/vue-practice.yml)
