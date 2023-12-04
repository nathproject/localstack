import json
import os

def lambda_handler(event, context):
    for record in event["Records"]:
        try:
            message = json.loads(record["body"])
            
            print(f"Received message: {message}")

        except json.JSONDecodeError:
            print("Failed to parse message body")
            continue

    return {"statusCode": 200,  "body": "Processing complete"}
