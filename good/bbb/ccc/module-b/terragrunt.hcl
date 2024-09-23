dependency "databricks_workspace" {
  config_path  = "../_workspace"
  skip_outputs = true
}

terraform {
  source = "../../../..//tf"
}
