# Get Caller Identity Info
data "aws_caller_identity" "current" {}

# Call ml-pipeline module
module "ml-pipeline" {
  source = "../ml-pipeline-module"
  project_name = var.project_name
  training_instance_type = var.training_instance_type
  inference_instance_type = var.inference_instance_type
  volume_size_sagemaker = var.volume_size_sagemaker
  s3_bucket_input_training_path = local.s3_bucket_input_training_path
  s3_object_training_data = local.s3_object_training_data
  s3_bucket_output_models_path = local.s3_bucket_output_models_path
  lambda_function_name = local.lambda_function_name
  handler_path = var.handler_path
  handler = var.handler
  lambda_folder = local.lambda_folder
  lambda_zip_filename = local.lambda_zip_filename
}

# Output ECR Repository URL
output "ecr_repository_url" {
  value = module.ml-pipeline.ecr_repository_url
  description = "ECR URL for the Docker Image"
}
