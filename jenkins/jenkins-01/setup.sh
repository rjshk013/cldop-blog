#!/bin/bash

# Exit script on error
set -e

echo "Preparing environment for Jenkins deployment..."

# Define SSH keys directory
JENKINS_AGENT_KEYS_DIR="./jenkins_agent_keys"

# Create SSH keys directory
echo "Creating SSH keys directory for Jenkins Agent..."
mkdir -p "$JENKINS_AGENT_KEYS_DIR"

# Generate SSH keys for Jenkins Agent
echo "Generating SSH keys for Jenkins Agent..."
if [ ! -f "$JENKINS_AGENT_KEYS_DIR/id_rsa" ]; then
  ssh-keygen -t rsa -b 4096 -f "$JENKINS_AGENT_KEYS_DIR/id_rsa" -N ""
  chmod 600 "$JENKINS_AGENT_KEYS_DIR/id_rsa"
  chmod 644 "$JENKINS_AGENT_KEYS_DIR/id_rsa.pub"
else
  echo "SSH keys already exist. Skipping key generation."
fi

# Copy public key to authorized_keys
echo "Configuring authorized_keys for Jenkins Agent..."
cp "$JENKINS_AGENT_KEYS_DIR/id_rsa.pub" "$JENKINS_AGENT_KEYS_DIR/authorized_keys"
chmod 644 "$JENKINS_AGENT_KEYS_DIR/authorized_keys"

# Set permissions for SSH keys directory
chmod -R 700 "$JENKINS_AGENT_KEYS_DIR"

# Ensure everything is ready
echo "Environment setup is complete!"
echo "You can now run 'docker-compose up -d' to start Jenkins."
