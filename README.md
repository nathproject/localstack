# Adding Services
## creating SQS queues
1. `aws sqs create-queue --profile localstack --queue-name WebOrders-DLQ --attributes '{"RedriveAllowPolicy": "{\"redrivePermission\":\"allowAll\"}"}'`

2. `aws sqs create-queue --profile localstack --queue-name WebOrders --attributes '{"RedrivePolicy": "{\"deadLetterTargetArn\":\"arn:aws:sqs:us-east-1:000000000000:WebOrders-DLQ\",\"maxReceiveCount\":2}"}'`

## creating the Lambda function with role
1. `aws --profile localstack iam create-role --role-name MyLambdaRole --assume-role-policy-document file://lambda/trust-policy.json`
2. `aws iam --profile localstack attach-role-policy --role-name MyLambdaRole --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaSQSQueueExecutionRole`
3. `aws --profile localstack iam attach-role-policy --role-name MyLambdaRole --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole`
4. `aws --profile localstack lambda create-function --function-name MyLambdaFunction --runtime python3.8 --handler lambda.lambda_handler --role arn:aws:iam::000000000000:role/MyLambdaRole --zip-file fileb://lambda/funcion.zip`
5.  creating the event source mapping `aws --profile localstack lambda create-event-source-mapping   --function-name MyLambdaFunction --event-source-arn arn:aws:sqs:us-east-1:000000000000:WebOrders   --batch-size 1`
