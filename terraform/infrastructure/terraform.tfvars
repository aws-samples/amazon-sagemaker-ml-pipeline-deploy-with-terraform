## Change project_name to your project name
project_name = "ml-pipeline-terraform-demo" //put your project name here
region = "eu-west-1" //change region if desired to deploy in another region

## Change instance types amd volume size for SageMaker if desired
training_instance_type = "ml.m5.xlarge"
inference_instance_type = "ml.c5.large"
volume_size_sagemaker = 5

## Should not be changed with the current folder structure
handler_path  = "../../src/lambda_function"
handler       = "config_lambda.lambda_handler"

