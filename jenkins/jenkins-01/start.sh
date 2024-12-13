#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
JENKINS_HOME_DIR=jenkins_home
JENKINS_AGENT_KEYS_DIR=jenkins_agent_keys
SECRETS_DIR=secrets

echo "Starting Jenkins setup..."

# Step 1: Create required directories
echo "Creating directories..."
mkdir -p $JENKINS_HOME_DIR $JENKINS_AGENT_KEYS_DIR $SECRETS_DIR

# Step 2: Set permissions
echo "Setting permissions for directories..."
sudo chown -R 1000:1000 $JENKINS_HOME_DIR
chmod 700 $JENKINS_AGENT_KEYS_DIR $SECRETS_DIR

# Step 3: Generate SSH keys for Jenkins agent
echo "Generating SSH keys for Jenkins agent..."
ssh-keygen -t rsa -b 4096 -f ./$JENKINS_AGENT_KEYS_DIR/id_rsa -N ""
chmod 600 ./$JENKINS_AGENT_KEYS_DIR/id_rsa
chmod 644 ./$JENKINS_AGENT_KEYS_DIR/id_rsa.pub

# Step 4: Configure secrets
echo "Configuring Jenkins secrets..."
echo "admin" > $SECRETS_DIR/jenkins_admin_user
echo "Admin@12345" > $SECRETS_DIR/jenkins_admin_password
chmod 600 $SECRETS_DIR/jenkins_admin_user $SECRETS_DIR/jenkins_admin_password





