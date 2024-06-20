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

For local testing with k3d, comment out the 'loadbalancer' form in the service object.

```terraform
  spec {
    # type = "LoadBalancer"
    port {
      port        = var.ingress_port
      target_port = var.container_port
      protocol    = "TCP"
    }
    selector = local.pod_labels
  }
```

## kubectl AWS

```bash
aws eks update-kubeconfig --region <REGION> --name <EKS_CLUSTER_NAME>
```

## Terratest

```bash
cd modules/test
go test -v -timeout 30m
go test -v -timeout 30m -run TestHelloWorldAppExample
go test -v -timeout 30m -parallel 2
```

### Integration tests

For testing multiple modules in the staging environment, extract the state S3 config into a separate file.
This will prevent overwriting the state file and can be used manually:

```bash
terraform init -backend-config=backend.hcl
```

## License

This code is released under the MIT License.
