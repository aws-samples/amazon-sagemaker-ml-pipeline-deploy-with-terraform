# Deploy and manage Machine Learning pipelines with Terraform using Amazon SageMaker

This repository contains Infrastructure as Code (IaC) to create and manage AWS infrastructure for a Machine Learning pipeline with SageMaker and 
Step Functions. Further it contains sample code for a Docker image to train and serve according to custom models on SageMaker. 


### Deploy AWS Infrastructure with Terraform
In order to deploy the ML pipeline, you will need to adjust the project name variable. The code for the Terraform part is in this repository in the folder:
```shell script
/terraform
```

When initialising for the first time:

- Open the file "terraform/infrastructure/terraform.tfvars" and adjust the variable "project_name" 
to the name of your project, as well as the variable "region" if you want to deploy in another region.
Further, you can change additional variables such as instance types for training and inference.
 
Afterwards follow the steps below to deploy the infrastructure with Terraform.

```shell script
export AWS_PROFILE=<your_aws_cli_profile_name>

cd terraform/infrastructure

terraform init

terraform plan

terraform apply
```
Check the output and make sure the planned resources appear correctly and confirm with ‘yes’ in the apply stage if
everything is correct. Once successfully applied, go to ECR (or check the output of Terraform in the Terminal) 
and get the URL for your ECR repository just created via Terraform.


### Push your Docker Image to ECR

For the ML pipeline and SageMaker to train and provision an endpoint for inference, you need to provide a Docker image and store it in ECR.
In the folder "sagemaker_byo" you will find an example, which relies on this repository 
https://github.com/aws/amazon-sagemaker-examples/tree/master/advanced_functionality/scikit_bring_your_own. 
If you already have applied the AWS infrastructure from the Terraform part, you can just push the Docker image
as described below. Once your Docker image is developed, you can take the following actions and push it to ECR (adapt the ECR URL 
according to your output URL from the previous step):

```shell script
cd src/container

export AWS_PROFILE=<your_aws_cli_profile_name> #If already done at the step above and profile still active, skip this step

aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin <account_number>.dkr.ecr.eu-west-1.amazonaws.com

docker build -t ml-training .

docker tag ml-training:latest <account_number>.dkr.ecr.eu-west-1.amazonaws.com/<ecr_repository_name>:latest

docker push <account_number>.dkr.ecr.eu-west-1.amazonaws.com/<ecr_repository_name>
```

### Run the ML pipeline

In order to train and run the ML pipeline, go to Step Functions and start the execution. You can check progress of
SageMaker also in the Training Jobs section of SageMaker and once the SageMaker Endpoint is created you can 
also check your SageMaker Endpoint. After running the State Machine in Step Functions successfully, you will see the
SageMaker Endpoint being created in the AWS Console in the SageMaker Endpoints section. Make sure to 
wait for the Status to change to “InService”.

### Invoke your endpoint

In order to invoke your endpoint (in this example for the iris dataset), you can use the following
Python script with boto3 (Python SDK) to invoke your endpoint, for example from a Amazon SageMaker notebook.
```python
import boto3
from io import StringIO
import pandas as pd

client = boto3.client('sagemaker-runtime')

endpoint_name = 'Your endpoint name' # Your endpoint name.
content_type = "text/csv"   # The MIME type of the input data in the request body.

payload = pd.DataFrame([[1.5,0.2,4.4,2.6]])
csv_file = StringIO()
payload.to_csv(csv_file, sep=",", header=False, index=False)
payload_as_csv = csv_file.getvalue()

response = client.invoke_endpoint(
    EndpointName=endpoint_name, 
    ContentType=content_type,
    Body=payload_as_csv
    )

label = response['Body'].read().decode('utf-8')
print(label)
```

### Cleanup

In order to clean up, you can destroy the infrastructure created by Terraform with the command “terraform destroy”. 
But you will need to delete the data and files in the S3 buckets first. Further, the SageMaker Endpoint (or multiple
SageMaker Endpoints if run multiple times) created via Step Functions is not managed via Terraform, but rather deployed
when running the ML pipeline with Step Functions. Therefore, make sure you delete the SageMaker Endpoints created via
the Step Function ML pipeline as well to avoid unnecessary costs.

### Steps:

- Delete the dataset in the S3 training bucket and all models you trained via the ML pipeline in the S3 bucket for the
 models in the AWS Console or via the AWS CLI
 
- Destroy the infrastructure created via Terraform
```shell script
cd terraform/infrastructure

terraform destroy
```
- Delete the SageMaker Endpoints, Endpoint Configuration and Models created via the Step Function in the AWS Console
or via the AWS CLI.


