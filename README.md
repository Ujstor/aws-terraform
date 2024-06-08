# Terraform: Up & Running Code

This repo contains my code implementation for the book *[Terraform: Up and Running](http://www.terraformupandrunning.com)* 

## Packer

To build the Amazon Machine Image (AMI):

```bash
packer build webserver.json
```

## Local k8s cluster:
[k3d](https://k3d.io/v5.6.3/usage/configfile/) is a lightweight wrapper to run [k3s](https://k3s.io/) (Rancher Lab’s minimal Kubernetes distribution) in docker.

```bash
k3d cluster create terraform \
  --servers 3 \
  --agents 3 \
  -p "80:80@loadbalancer" \
  -p "443:443@loadbalancer" \
  --k3s-node-label "type=control@server:0,1,2" \
  --k3s-node-label "type=worker@agent:0,1,2"
```

## License

This code is released under the MIT License.
