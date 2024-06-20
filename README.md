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

## Dir structure

```bash
[4.0K]  ./
├── [4.0K]  global/
│   ├── [4.0K]  ghAction/
│   │   ├── [1.6K]  main.tf
│   │   ├── [ 535]  outputs.tf
│   │   ├── [ 411]  terraform.tf
│   │   ├── [ 992]  tf-apply.yml
│   │   └── [ 308]  variables.tf
│   ├── [4.0K]  iam/
│   │   ├── [1.2K]  main.tf
│   │   ├── [1.7K]  outputs.tf
│   │   ├── [ 375]  terraform.tf
│   │   └── [ 472]  variables.tf
│   └── [4.0K]  s3/
│       ├── [ 930]  main.tf
│       ├── [ 259]  outputs.tf
│       ├── [ 374]  terraform.tf
│       └── [ 330]  variables.tf
├── [4.0K]  modules/
│   ├── [4.0K]  examples/
│   │   ├── [4.0K]  alb/
│   │   │   ├── [ 207]  dependencies.tf
│   │   │   ├── [ 177]  main.tf
│   │   │   ├── [ 382]  outputs.tf
│   │   │   ├── [ 320]  terraform.tf
│   │   │   ├── [5.9K]  terraform.tfstate
│   │   │   ├── [ 181]  terraform.tfstate.backup
│   │   │   └── [ 116]  variables.tf
│   │   ├── [4.0K]  asg/
│   │   │   └── [4.0K]  one-instance/
│   │   │       ├── [ 439]  dependencies.tf
│   │   │       ├── [ 370]  main.tf
│   │   │       ├── [ 111]  outputs.tf
│   │   │       ├── [ 321]  terraform.tf
│   │   │       └── [  79]  variables.tf
│   │   └── [4.0K]  hello-world-app/
│   │       └── [4.0K]  standalone/
│   │           ├── [ 721]  dependencies.tf
│   │           ├── [ 422]  main.tf
│   │           ├── [ 109]  outputs.tf
│   │           ├── [ 319]  terraform.tf
│   │           ├── [ 29K]  terraform.tfstate
│   │           ├── [1.0K]  terraform.tfstate.backup
│   │           └── [ 625]  variables.tf
│   ├── [4.0K]  modules/
│   │   ├── [4.0K]  cluster/
│   │   │   └── [4.0K]  asg-rolling-deploy/
│   │   │       ├── [  80]  dependencies.tf
│   │   │       ├── [3.5K]  main.tf
│   │   │       ├── [ 274]  outputs.tf
│   │   │       ├── [ 159]  terraform.tf
│   │   │       └── [1.9K]  variables.tf
│   │   ├── [4.0K]  data-stores/
│   │   │   └── [4.0K]  mysql/
│   │   │       ├── [ 669]  main.tf
│   │   │       ├── [ 338]  outputs.tf
│   │   │       ├── [ 159]  terraform.tf
│   │   │       └── [1.3K]  variables.tf
│   │   ├── [4.0K]  eks-cluster/
│   │   │   ├── [ 233]  dependencies.tf
│   │   │   ├── [2.3K]  main.tf
│   │   │   ├── [ 517]  outputs.tf
│   │   │   ├── [ 159]  terraform.tf
│   │   │   └── [ 583]  variables.tf
│   │   ├── [4.0K]  k8s/
│   │   │   ├── [1.3K]  main.tf
│   │   │   ├── [ 368]  outputs.tf
│   │   │   ├── [ 159]  terraform.tf
│   │   │   └── [ 662]  variables.tf
│   │   ├── [4.0K]  networking/
│   │   │   └── [4.0K]  alb/
│   │   │       ├── [1.2K]  main.tf
│   │   │       ├── [ 367]  outputs.tf
│   │   │       ├── [ 158]  terraform.tf
│   │   │       └── [ 187]  variables.tf
│   │   └── [4.0K]  services/
│   │       └── [4.0K]  hello-world-app/
│   │           ├── [ 797]  dependencies.tf
│   │           ├── [1.4K]  main.tf
│   │           ├── [ 389]  outputs.tf
│   │           ├── [ 159]  terraform.tf
│   │           ├── [ 168]  user-data.sh
│   │           └── [2.0K]  variables.tf
│   └── [4.0K]  test/
│       ├── [ 870]  alb_example_test.go
│       ├── [2.6K]  go.mod
│       ├── [ 94K]  go.sum
│       └── [1.0K]  hello_world_test.go
├── [4.0K]  packer/
│   ├── [ 576]  webserver.json
│   └── [ 724]  webserver.json.pkr.hcl
├── [4.0K]  prod/
│   ├── [4.0K]  data-stores/
│   │   └── [4.0K]  mysql/
│   │       ├── [ 626]  main.tf
│   │       ├── [ 783]  output.tf
│   │       ├── [ 712]  terraform.tf
│   │       └── [ 265]  variables.tf
│   └── [4.0K]  services/
│       ├── [4.0K]  eks-cluster/
│       │   ├── [  81]  dependencies.tf
│       │   ├── [ 693]  main.tf
│       │   ├── [ 257]  outputs.tf
│       │   └── [ 776]  terraform.tf
│       └── [4.0K]  hello-world-app/
│           ├── [ 202]  dependencies.tf
│           ├── [ 572]  main.tf
│           ├── [ 111]  outputs.tf
│           └── [ 538]  terraform.tf
├── [4.0K]  stage/
│   ├── [4.0K]  data-stores/
│   │   └── [4.0K]  mysql/
│   │       ├── [ 389]  main.tf
│   │       ├── [ 337]  output.tf
│   │       ├── [ 648]  terraform.tf
│   │       └── [ 266]  variables.tf
│   └── [4.0K]  services/
│       ├── [4.0K]  hello-world-app/
│       │   ├── [ 202]  dependencies.tf
│       │   ├── [ 587]  main.tf
│       │   ├── [ 109]  outputs.tf
│       │   └── [ 656]  terraform.tf
│       └── [4.0K]  k8s/
│           ├── [ 420]  main.tf
│           ├── [ 127]  outputs.tf
│           └── [ 571]  terraform.tf
├── [1.0K]  LICENSE.txt
├── [5.7K]  README.md
└── [ 180]  terraform.tfstate
```

## License

This code is released under the MIT License.
