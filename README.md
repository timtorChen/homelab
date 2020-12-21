# Home cluster

This repo is a collection of my homelab cluster. Node machines are Raspberry PI4 (arm64 architecture). Cluster is orchestrated with [k3s](https://github.com/rancher/k3s), and services are managed with [helmfile](https://github.com/roboll/helmfile).

## Services

### k3s default service

- kube-system
  - coredns - cluster DNS

### helm releases

- system
  - metabllb - load balancer for bare-metal cluster
  - nginx-ingress-controller - ingress controller
  - cert-manager - certificate request and renew manager
  - openvpn - old but the most general VPN
  - wireguard-access-server - wireguard VPN with a simple UI
  - adguard-home - custom DNS and ad-blocker
  - prometheus - service monitoring and alerting
  - grafana - prometheus data visualization UI

- default
  - bitwarden-rs - password manager
  - jellyfin - media streaming server
  - nextcloud - cloud server
  - blog - my gatsby blog

## Thanks

- A great [tutorial series](https://greg.jeanmart.me/2020/04/13/build-your-very-own-self-hosting-platform-wi/) build a Raspberry PI k3s cluster by Greg Jeanmart.
- The [awesome-home-kubernetes](https://github.com/k8s-at-home/awesome-home-kubernetes) community repo, folks build and share cluster infra with diverse gitops management method.

- [Penguin highway OST](https://www.youtube.com/watch?v=v1ZEOFDYfj0&list=PLUEmlXHxi3ky8VVRh13eSTBOhYiwdgCfh)
