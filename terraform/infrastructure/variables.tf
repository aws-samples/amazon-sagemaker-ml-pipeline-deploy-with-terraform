variable "region" {
  type    = string
}

variable "project_name" {
  type = string
}

variable "handler_path" {
  type = string
}

variable "handler" {
  type = string
}

variable "runtime" {
  type = string
  default = "python3.7"
}

variable "memory_size" {
  type = string
  default = "128"
}

variable "timeout" {
  type = string
  default = "200"
}

variable "training_instance_type" {
  type = string
}

variable "inference_instance_type" {
  type = string
}

variable "volume_size_sagemaker" {
  type = number
}
