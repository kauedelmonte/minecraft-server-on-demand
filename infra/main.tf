module "network" {
  source      = "./network"
  namespace   = var.namespace
  environment = var.environment
}

module "compute" {
  source                    = "./compute"
  namespace                 = var.namespace
  environment               = var.environment
  ec2_public_key            = var.ec2_public_key
  public_subnet_ids         = module.network.public_subnet_ids
  private_subnet_ids        = module.network.private_subnet_ids
  proxy_security_group_id   = module.network.proxy_security_group_id
  backend_security_group_id = module.network.backend_security_group_id

  proxy_instance_type     = var.proxy_instance_type
  backend_instance_type   = var.backend_instance_type
  proxy_container_image   = var.proxy_container_image
  backend_container_image = var.backend_container_image

  proxy_container_cpu      = var.proxy_container_cpu
  proxy_container_memory   = var.proxy_container_memory
  backend_container_cpu    = var.backend_container_cpu
  backend_container_memory = var.backend_container_memory

  proxy_container_port   = var.proxy_container_port
  proxy_bedrock_port     = var.proxy_bedrock_port
  backend_container_port = var.backend_container_port

  proxy_desired_count   = var.proxy_desired_count
  backend_desired_count = var.backend_desired_count

  backend_asg_min     = var.backend_asg_min
  backend_asg_max     = var.backend_asg_max
  backend_asg_desired = var.backend_asg_desired

  log_retention_in_days = var.log_retention_in_days
}

module "dns" {
  source    = "./dns"
  zone_name = var.proxy_domain_name
  proxy_eip = module.compute.proxy_eip_public_ip
}
