# Makefile for deploying cognito-app-infra CI/CD pipeline

# Variables
STACK_NAME = cognito-app-infra-pipeline
TEMPLATE_FILE = cognito-app-infra-pipeline.yaml
REGION = eu-west-1  # Change this to your preferred region

# Parameters (replace these with your actual values)
GITHUB_OWNER = AfricaBlue72
GITHUB_REPO = cognito-app
GITHUB_BRANCH = master
GITHUB_CONNECTION_ARN = arn:aws:codeconnections:eu-west-1:970547379959:connection/5b4119bf-a7ea-40e0-b7a3-54607728cfb5
ACCEPT_ACCOUNT_ID = 970547379959  # Replace with your actual Accept account ID
PRODUCTION_ACCOUNT_ID = 288761731516
DEPLOYER_ROLE_NAME = CICDForCognitoAppInfra  # Replace with your actual deployer role name
CODEBUILD_IMAGE = aws/codebuild/amazonlinux2-x86_64-standard:5.0  # Replace with your preferred CodeBuild image

.PHONY: deploy

deploy:
	aws cloudformation deploy \
		--template-file $(TEMPLATE_FILE) \
		--stack-name $(STACK_NAME) \
		--region $(REGION) \
		--capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM \
		--parameter-overrides \
			GitHubOwner=$(GITHUB_OWNER) \
			GitHubRepo=$(GITHUB_REPO) \
			GitHubBranch=$(GITHUB_BRANCH) \
			GitHubConnectionArn=$(GITHUB_CONNECTION_ARN) \
			AcceptAccountId=$(ACCEPT_ACCOUNT_ID) \
			ProductionAccountId=$(PRODUCTION_ACCOUNT_ID) \
			DeployerRoleName=$(DEPLOYER_ROLE_NAME) \
			CodeBuildImage=$(CODEBUILD_IMAGE)
