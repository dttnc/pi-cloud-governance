.PHONY: fmt lint test-dry-run mock-audit help plan-github apply-github

help:
	@echo "GCP & GitHub Governance GitOps - Developer Tasks"
	@echo "-------------------------------------------------"
	@echo "make fmt          : Format all Terraform files recursively"
	@echo "make lint         : Verify syntax of Terraform and Python"
	@echo "make plan-github  : Run speculative plan for GitHub governance stack"
	@echo "make dry-run      : Run dry-run IAM snapshot pipeline"

fmt:
	terraform -chdir=terraform fmt -recursive

lint:
	terraform -chdir=terraform/github fmt -check
	terraform -chdir=terraform/gcp fmt -check
	python3 -m py_compile governance_pipeline/extract_iam.py

plan-github:
	terraform -chdir=terraform/github init
	terraform -chdir=terraform/github plan -var-file=../definitions/github.tfvars

dry-run:
	python3 governance_pipeline/extract_iam.py --dry-run
