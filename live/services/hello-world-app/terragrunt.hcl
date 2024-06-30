terraform {
  source = "github.com/ujstor/aws-terraform//modules/modules/services/hello-world-app?ref=v0.1.4"
}

include {
  path = find_in_parent_folders()
}

dependency "mysql" {
  config_path = "../../data-stores/mysql/"
}

inputs = {
  environment = "live"
  image_id = "ami-04b70fa74e45c3917"
  instance_type = "t2.micro"

  min_size = 2
  max_size = 5

  enable_autoscaling = false
  
  mysql_config = dependency.mysql.outputs
}

