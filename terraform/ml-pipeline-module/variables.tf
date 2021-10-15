variable region {
  type    = string
  default = "eu-west-1"
}

variable project_name {
  type = string
  description = "Name of the project"
}

variable training_instance_type {
  type = string
  description = "Instance type for training the ML model"
}

variable inference_instance_type {
  type = string
  description = "Instance type for training the ML model"
}

variable s3_bucket_input_training_path {
  type = string
  description = "S3 path where training data is stored"
}

variable s3_object_training_data {
  type = string
  description = "S3 path where training data is stored"
}

variable s3_bucket_output_models_path {
  type = string
  description = "S3 path were the output (trained models etc.) will be stored"
}

variable lambda_function_name {
  type = string
  description = "Name of the lambda function creating a unique ID"
}
variable handler_path {
  type = string
  description = "Path of the lambda handler"
}

variable handler {
  type = string
  description = "Name of the lambda function handler"
}

variable "runtime" {
  type = string
  default = "python3.7"
}

variable "memory_size" {
  type = string
  description = "Memory Lambda in MB"
  default = "128"
}

variable "timeout" {
  type = string
  description = "Timeout Lambda in Seconds"
  default = "200"
}

variable lambda_folder {
  type = string
  description = "Folder for the lambda function"
}

variable lambda_zip_filename {
  type = string
  description = "The filename of the zip function from the lambda function"
}

variable volume_size_sagemaker {
  type = number
  description = "Volume size SageMaker instance in GB"
}
