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
else
  echo "SSH keys already exist. Skipping key generation."
fi

# Copy public key to authorized_keys
echo "Configuring authorized_keys for Jenkins Agent..."
cp "$JENKINS_AGENT_KEYS_DIR/id_rsa.pub" "$JENKINS_AGENT_KEYS_DIR/authorized_keys"

# Set correct permissions for the .ssh directory and files
echo "Setting correct permissions for SSH keys..."
chmod 700 "$JENKINS_AGENT_KEYS_DIR"
chmod 600 "$JENKINS_AGENT_KEYS_DIR/id_rsa"
chmod 644 "$JENKINS_AGENT_KEYS_DIR/id_rsa.pub"
chmod 600 "$JENKINS_AGENT_KEYS_DIR/authorized_keys"

# Set ownership to Jenkins user (UID: 1000)
echo "Setting ownership for SSH keys directory..."
chown -R 1000:1000 "$JENKINS_AGENT_KEYS_DIR"

# Completion message
echo "Environment setup is complete!"
echo "You can now run 'docker-compose up -d' to start Jenkins."
