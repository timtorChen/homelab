<div align="center">

### My Homelab :octocat:

... _progressing with [未来のミュージアム](https://www.youtube.com/watch?v=s8_vqfjYpBg)_ 🎧

</div>

<div align="center">

[![Discord](https://img.shields.io/discord/673534664354430999?style=for-the-badge&label&logo=discord&logoColor=white&color=blue)](https://discord.gg/home-operations)&nbsp;&nbsp;
[![Talos](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.timtor.dev%2Fquery%3Fformat%3Dendpoint%26metric%3Dtalos_version&style=for-the-badge&logo=talos&logoColor=white&color=blue&label=%20)](https://www.talos.dev/)&nbsp;&nbsp;
[![Kubernetes](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.timtor.dev%2Fquery%3Fformat%3Dendpoint%26metric%3Dkubernetes_version&style=for-the-badge&logo=kubernetes&logoColor=white&color=blue&label=%20)](https://www.talos.dev/)&nbsp;&nbsp;
[![Renovate](https://img.shields.io/github/actions/workflow/status/timtorChen/homelab/renovate.yaml?branch=main&label=&logo=renovatebot&style=for-the-badge&color=blue)](https://github.com/onedr0p/home-ops/actions/workflows/renovate.yaml)

</div>

<div align="center">

[![Age](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.timtor.dev%2Fquery%3Fformat%3Dendpoint%26metric%3Dnode_age%26label%3D&style=flat-square&color=green&label=Age)](https://github.com/kashalls/kromgo/)&nbsp;&nbsp;
[![Node-Count](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.timtor.dev%2Fquery%3Fformat%3Dendpoint%26metric%3Dnode_count%26label%3D&style=flat-square&color=green&label=Node)](https://github.com/kashalls/kromgo/)&nbsp;&nbsp;
[![Pod-Count](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.timtor.dev%2Fquery%3Fformat%3Dendpoint%26metric%3Dpod_count%26label%3D&style=flat-square&color=green&label=Pod)](https://github.com/kashalls/kromgo/)&nbsp;&nbsp;
[![CPU-Usage](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.timtor.dev%2Fquery%3Fformat%3Dendpoint%26metric%3Dcpu_usage%26label%3D&style=flat-square&label=CPU)](https://github.com/kashalls/kromgo/)&nbsp;&nbsp;
[![Memory-Usage](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.timtor.dev%2Fquery%3Fformat%3Dendpoint%26metric%3Dmemory_usage%26label%3D&style=flat-square&label=Memory)](https://github.com/kashalls/kromgo/)&nbsp;&nbsp;
[![Power-Consumption](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.timtor.dev%2Fquery%3Fformat%3Dendpoint%26metric%3Dpower_consumption%26label%3D&style=flat-square&label=Power)](https://github.com/kashalls/kromgo/)&nbsp;&nbsp;

</div>

---

## 📖 Overview

This is a mono repository for my home infrastructure and Kubernetes cluster. I use [Talos](https://github.com/siderolabs/talos) Kubernetes distribution, and follows the concept Infrastructure as Code (IaC), using the tools like [Flux](https://github.com/fluxcd/flux2), [Terraform](https://github.com/hashicorp/terraform), [Renovate](https://github.com/renovatebot/renovate) and [Github Actions](https://github.com/features/actions).

## Architecture

![](./docs/src/arch.png)

## 🚢 Technology Stack

|                                                                                                                                                      | Name                                                                                      | Description                                                         |
| :--------------------------------------------------------------------------------------------------------------------------------------------------: | ----------------------------------------------------------------------------------------- | ------------------------------------------------------------------- |
|                                             <img width="32" src="https://www.talos.dev/images/logo.svg">                                             | [Talos](https://github.com/siderolabs/talos)                                              | Immutable Linux distribution for Kubernetes.                        |
|                     <img width="28" src="https://github.com/cncf/artwork/raw/main/projects/flux/icon/color/flux-icon-color.svg">                     | [Flux](https://github.com/fluxcd/flux2)                                                   | Gitops tool to reconcile sources from Git repository to Kubernetes. |
|                  <img width="32" src="https://github.com/cncf/artwork/raw/main/projects/kyverno/icon/color/kyverno-icon-color.svg">                  | [Kyverno](https://github.com/kyverno/kyverno)                                             | Kubernetes policy manager.                                          |
|                   <img width="32" src="https://github.com/cncf/artwork/raw/main/projects/cilium/icon/color/cilium_icon-color.svg">                   | [Cilium](https://github.com/cilium/cilium)                                                | Advanced networking.                                                |
|                                   <img width="32" src="https://metallb.universe.tf/images/logo/metallb-blue.png">                                    | [Metallb](https://github.com/metallb/metallb)                                             | IP address announcement and allocation for Kubernetes LoadBalancer. |
|            <img width="32" src="https://upload.wikimedia.org/wikipedia/commons/thumb/9/94/Cloudflare_Logo.png/240px-Cloudflare_Logo.png">            | [Cloudflared](https://github.com/cloudflare/cloudflared)                                  | Encrypted tunnel between server and Cloudflare.                     |
|             <img width="32" src="https://github.com/cncf/artwork/raw/main/projects/cert-manager/icon/color/cert-manager-icon-color.png">             | [Cert-manager](https://github.com/cert-manager/cert-manager)                              | Public and private certificate controller.                          |
|              <img width="48"  src="https://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/Nginx_logo.svg/320px-Nginx_logo.svg.png">               | [Ingress-nginx](https://github.com/Kubernetes/ingress-nginx)                              | Simple ingress controller.                                          |
|                     <img width="32" src="https://github.com/cncf/artwork/raw/main/projects/rook/icon/color/rook-icon-color.png">                     | [Rook-ceph](https://github.com/rook/rook)                                                 | Ceph operator, providing block, object and file storage.            |
|                                  <img width="32" src="https://avatars.githubusercontent.com/u/47803932?s=200&v=4">                                   | [Volsync](https://github.com/backube/volsync)                                             | Persistent Volume snapshot and backup.                              |
|                                  <img width="32" src="https://avatars.githubusercontent.com/u/100373852?s=200&v=4">                                  | [CloudNativePG](https://github.com/cloudnative-pg/cloudnative-pg)                         | Postgres operator.                                                  |
|                                       <img width="32" src="https://grafana.com/static/img/menu/grafana2.svg">                                        | [Grafana LG~~T~~M](https://github.com/grafana)                                            | System monitoring.                                                  |
| <img width="32" src="https://upload.wikimedia.org/wikipedia/commons/thumb/9/93/Amazon_Web_Services_Logo.svg/320px-Amazon_Web_Services_Logo.svg.png"> | [Amazon-eks-pod-identity-webhook](https://github.com/aws/amazon-eks-pod-identity-webhook) | ServiceAccount token injection for Pod to access AWS.               |

## ☁️ Cloud Services

| Service       | Usage                                      | Cost            |
| :------------ | :----------------------------------------- | :-------------- |
| Github        | Code repository and automation chores/jobs | Free            |
| JumpCloud     | SSO identity provider                      | Free            |
| Cloudflare    | Domain registrar and tunnel                | $10/year        |
| Backblaze     | S3 bucket for buckup                       | ~$1/month       |
| AWS           | Parameter storage and terraform backend    | Free            |
| Grafana Cloud | External montoring                         | Free            |
| Let's Encrypt | Public certificate authroity               | Free            |
|               |                                            | Total ~$22/year |

## 🔧 Hardware

<details>
<summary>Click to see the rack</summary>
<img src="docs/src/rack-20241103.jpg" width="400px"/>
</details>

| Device                          | Description                  | Count | RAM                        | Disk                                                                      |
| ------------------------------- | ---------------------------- | ----- | -------------------------- | ------------------------------------------------------------------------- |
| Askey RTF8207W                  | Chunghwa Telecom modem       | 1     |                            |                                                                           |
| Mikrotik RB4011iGS+RM           | Router                       | 1     |                            |                                                                           |
| Mikrotik CRS328-24P-4S+RM       | PoE Switch                   | 1     |                            |                                                                           |
| Raspberry Pi 4B with PoE hat    | Kubernetes control planes    | 1     | 8GB                        | 960GB SSD Micron 5200                                                     |
| Intel NUC11TNHi50L              | Kubernetes worker nodes      | 3     | 16\*2 Mircon CT16G4SFRA32A | <div>• OS: 960GB SSD Mircon 5300<div/><div>• Data: 960GB NVMe Mircon 7450 |
| Ubiquiti Power Distribution Pro | 16p Switched and metered PDU | 1     |                            |                                                                           |

## 🤝 Acknowledgments

Thanks to [Home Operations](https://discord.com/invite/home-operations) Discord community. I always find lots of cool ideas from chats. Also a special thanks to the great [series](https://greg.jeanmart.me/2020/04/13/build-your-very-own-self-hosting-platform-wi/), by Grégoire Jeanmart, which motivate me to start this project.

## 📄 License

Code is under the [MIT License](./LICENSE).
Document and image is avaliable under [CC BY-SA 4.0 License](https://creativecommons.org/licenses/by-sa/4.0/).
