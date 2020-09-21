# Hola PI cluster
Personal raspberry PI cluster with [k3s](https://github.com/rancher/k3s), [helm](https://github.com/helm/helm), and [helmfile](https://github.com/roboll/helmfile) stacks.


### helm plugins 
helm-diff, helm-git, helm-secrets

```bash
helm plugin install https://github.com/databus23/helm-diff
helm plugin install https://github.com/zendesk/helm-secrets
helm plugin install https://github.com/aslafy-z/helm-git
```

Motivation: [Sea Horizon](https://www.youtube.com/watch?v=tVhJk1pPh5U&t=2s)