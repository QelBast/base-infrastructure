SHELL := pwsh.exe
.SHELLFLAGS := -Command

ST1DIR = .\1-packer-node-os
ST2DIR = .\2-packer-proxmox
ST3DIR = .\3-deploy-proxmox

TF = terraform
PKR = packer
PROXY = http://localhost:34822
# --- Variables file (git ignore)
TFVARS = -var-file=terraform.tfvars

# --- Proxy environment (for Terraform registry access) ---
export HTTP_PROXY=$(PROXY)
export HTTPS_PROXY=$(PROXY)

# --- Terraform logging
export TF_LOG=TRACE 
export TF_LOG_PATH=./tf.log

.PHONY: init plan apply all

all: init plan apply

stage1:
	$(PKR) init $(ST2DIR)
	$(PKR) build -var-file='$(ST2DIR)/variables.auto.pkrvars.hcl' '$(ST2DIR)'
stage2:
	$(ST3DIR)/deploy-proxmox -ConfigPath $(ST3DIR)\config.psd1
stage4:
	$(TF) apply -auto-approve -input=false