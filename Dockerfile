# base image
FROM amazon/aws-cli:2.14.5

ENV AWS_ACCESS_KEY_ID=test
ENV AWS_SECRET_ACCESS_KEY=test
ENV AWS_DEFAULT_REGION=us-east-1
ENV AWS_DEFAULT_OUTPUT=json
ENV AWS_ENDPOINT_URL=http://localstack:4566

# Copy entrypoint script
COPY entrypoint.sh /aws/entrypoint.sh
COPY lambda /aws/lambda

# Make the script executable
RUN chmod +x /aws/entrypoint.sh

# Set entrypoint
ENTRYPOINT ["/aws/entrypoint.sh"]

