#!/bin/bash

# Terraform Installation Script
set -e  # Exit immediately if a command exits with a non-zero status

# Define Terraform version (default to latest)
TERRAFORM_VERSION="1.7.0"
TERRAFORM_ZIP="terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
INSTALL_DIR="/usr/local/bin"

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install dependencies
if command_exists apt; then
    sudo apt update && sudo apt install -y unzip wget curl
elif command_exists yum; then
    sudo yum install -y unzip wget curl
elif command_exists dnf; then
    sudo dnf install -y unzip wget curl
else
    echo "Unsupported package manager. Install unzip, wget, and curl manually."
    exit 1
fi

# Download Terraform
echo "Downloading Terraform $TERRAFORM_VERSION..."
wget "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/${TERRAFORM_ZIP}" -O "/tmp/${TERRAFORM_ZIP}"

# Extract and move Terraform binary
unzip "/tmp/${TERRAFORM_ZIP}" -d /tmp/
sudo mv /tmp/terraform "$INSTALL_DIR"
sudo chmod +x "$INSTALL_DIR/terraform"

# Verify Installation
echo "Verifying Terraform installation..."
terraform version

# Cleanup
echo "Cleaning up..."
rm -f "/tmp/${TERRAFORM_ZIP}"

echo "Terraform $TERRAFORM_VERSION installation completed successfully."
