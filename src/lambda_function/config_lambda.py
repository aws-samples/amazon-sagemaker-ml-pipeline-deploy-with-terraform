import datetime

def lambda_handler(event, context):
    prefix_name = event['PrefixName']
    training_job_name = str(prefix_name) + '-' + datetime.datetime.utcnow().strftime('%Y%m%d%H%M%S')
    return training_job_name