module "db" {
  source = "./modules/vm"

  for_each       = var.db
  component_name = each.key

  rgname    = var.rgname
  image_id  = var.image_id
  env       = var.env
  subnet_id = var.subnet_id
  vm_count  = 1
}


module "apps" {
  depends_on = [module.db]
  source     = "./modules/vmss"

  for_each       = var.apps
  component_name = each.key

  env       = var.env
  image_id  = var.image_id
  rgname    = var.rgname
  subnet_id = var.subnet_id
}



# module "ui" {
#   source = "./modules/vm"
#
#   for_each       = var.ui
#   component_name = each.key
#   port           = each.value["port"]
#
#
#   rgname   = var.rgname
#   image_id = var.image_id
#   env      = var.env
#   lb_type  = "public"
#   vm_count = 2
#
#   depends_on = [module.apps]
# }
#
