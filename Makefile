# Makefile for deploying the CI/CD pipeline

# Variables
STACK_NAME = cognito-web-test-pipeline
TEMPLATE_FILE = pipeline.yaml
REGION = us-west-1  # Change this to your preferred region

# Parameters (these should be passed as environment variables or command-line arguments)
GITHUB_OWNER ?= AfricaBlue72
GITHUB_REPO ?= cognito-app
GITHUB_BRANCH ?= main
PRODUCTION_ACCOUNT_ID ?= 288761731516
PRODUCTION_BUCKET_NAME ?= your-production-bucket-name  # Replace with your actual production bucket name
GITHUB_SECRET_NAME = Github/cognito-app/PAT

# Deploy the stack
deploy:
	$(eval GITHUB_TOKEN := $(shell aws secretsmanager get-secret-value --secret-id $(GITHUB_SECRET_NAME) --query SecretString --output text --region $(REGION)))
	aws cloudformation deploy \
		--stack-name $(STACK_NAME) \
		--template-file $(TEMPLATE_FILE) \
		--region $(REGION) \
		--capabilities CAPABILITY_IAM \
		--parameter-overrides \
			GitHubOwner=$(GITHUB_OWNER) \
			GitHubRepo=$(GITHUB_REPO) \
			GitHubBranch=$(GITHUB_BRANCH) \
			GitHubToken=$(GITHUB_TOKEN) \
			ProductionAccountId=$(PRODUCTION_ACCOUNT_ID) \
			ProductionBucketName=$(PRODUCTION_BUCKET_NAME)

# Update the stack
update: deploy

# Delete the stack
delete:
	aws cloudformation delete-stack \
		--stack-name $(STACK_NAME) \
		--region $(REGION)

# Describe the stack
describe:
	aws cloudformation describe-stacks \
		--stack-name $(STACK_NAME) \
		--region $(REGION)

# Validate the template
validate:
	aws cloudformation validate-template \
		--template-body file://$(TEMPLATE_FILE) \
		--region $(REGION)

.PHONY: deploy update delete describe validate
