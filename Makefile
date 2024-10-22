# Makefile for deploying cognito-app-infra CI/CD pipeline

# Variables
STACK_NAME = cognito-app-infra-pipeline
TEMPLATE_FILE = cognito-app-infra-pipeline.yaml
REGION = us-east-1  # Change this to your preferred region

# Parameters (replace these with your actual values)
GITHUB_OWNER = AfricaBlue72
GITHUB_REPO = cognito-app-pipeline Public
GITHUB_BRANCH = main
GITHUB_CONNECTION_ARN = arn:aws:codeconnections:eu-west-1:970547379959:connection/5b4119bf-a7ea-40e0-b7a3-54607728cfb5
PRODUCTION_ACCOUNT_ID = your-production-account-id

.PHONY: deploy

deploy:
	aws cloudformation deploy \
		--template-file $(TEMPLATE_FILE) \
		--stack-name $(STACK_NAME) \
		--region $(REGION) \
		--capabilities CAPABILITY_IAM \
		--parameter-overrides \
			GitHubOwner=$(GITHUB_OWNER) \
			GitHubRepo=$(GITHUB_REPO) \
			GitHubBranch=$(GITHUB_BRANCH) \
			GitHubConnectionArn=$(GITHUB_CONNECTION_ARN) \
			ProductionAccountId=$(PRODUCTION_ACCOUNT_ID)
