SHELL := pwsh.exe
.SHELLFLAGS := -Command

ST1DIR = .\1-packer-proxmox
ST2DIR = .\2-packer-node-os
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
	$(PKR) init $(ST1DIR)
	$(PKR) build -var-file='$(ST1DIR)/variables.auto.pkrvars.hcl' '$(ST1DIR)'
stage2:
	$(PKR) init $(ST2DIR)
	$(PKR) build -var-file='$(ST2DIR)/variables.auto.pkrvars.hcl' '$(ST2DIR)'
stage3:
	$(ST3DIR)/deploy-proxmox -ConfigPath $(ST3DIR)\config.psd1