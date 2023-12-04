#!/bin/sh
aws sqs create-queue --queue-name WebOrders-DLQ --attributes '{"RedriveAllowPolicy": "{\"redrivePermission\":\"allowAll\"}"}'

aws sqs create-queue --queue-name WebOrders --attributes '{"RedrivePolicy": "{\"deadLetterTargetArn\":\"arn:aws:sqs:us-east-1:000000000000:WebOrders-DLQ\",\"maxReceiveCount\":2}"}'

aws iam create-role --role-name MyLambdaRole --assume-role-policy-document file://lambda/trust-policy.json

aws iam attach-role-policy --role-name MyLambdaRole --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaSQSQueueExecutionRole

aws iam attach-role-policy --role-name MyLambdaRole --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole

aws lambda create-function --function-name MyLambdaFunction --runtime python3.8 --handler lambda.lambda_handler --role arn:aws:iam::000000000000:role/MyLambdaRole --zip-file fileb://lambda/function.zip

aws lambda create-event-source-mapping   --function-name MyLambdaFunction --event-source-arn arn:aws:sqs:us-east-1:000000000000:WebOrders   --batch-size 1

#exec "$@"
