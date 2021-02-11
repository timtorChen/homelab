# Home cluster

This repo is a collection of my homelab cluster. Node machines are 4 Raspberry PI4 (three 8G RAM version, and one 4G RAM version). Cluster is instanced with [k3s](https://github.com/rancher/k3s), and services are managed with [helmfile](https://github.com/roboll/helmfile). All secrets are gpg encrypted using [sops](https://github.com/mozilla/sops).


## Helm releases by namespace
- kube-system (created while k3s instaced)
  - coredns 
  - kube-vip

- baremeal-system
  - metabllb
  - minio
  - local-provisioner
  - nfs-client-provisioner 

- longhorn-system
  - longhorn 

- ingress-system
  - nginx-ingress-controller
  - cert-manager
 
- monitor-system 
  - prometheus
  - grafana

- default
  - bitwarden-rs
  - jellyfin
  - nextcloud
  - blog

## Thanks

- A great [tutorial series](https://greg.jeanmart.me/2020/04/13/build-your-very-own-self-hosting-platform-wi/) build a Raspberry PI k3s cluster by Greg Jeanmart.
- The [awesome-home-kubernetes](https://github.com/k8s-at-home/awesome-home-kubernetes) community repo, folks build and share cluster infra with diverse gitops management method.

- [Penguin highway OST](https://www.youtube.com/watch?v=v1ZEOFDYfj0&list=PLUEmlXHxi3ky8VVRh13eSTBOhYiwdgCfh)
