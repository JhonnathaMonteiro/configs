#!/bin/bash
yum update -y

# Install nginx
# see https://www.digitalocean.com/community/tools/nginx
# https://stackoverflow.com/questions/57784287/how-to-install-nginx-on-aws-ec2-linux-2
# maybe git over aws s3
amazon-linux-extras install -y nginx1
systemctl -l enable nginx
systemctl -l start nginx

# Back up existing config
mv /etc/nginx /etc/nginx-backup

# Download the configuration from S3
aws s3 cp s3://{my_bucket}/nginxconfig.io-example.com.zip /tmp

# Install new configuration
unzip /tmp/nginxconfig.io-example.com.zip -d /etc/nginx

# Install Docker
yum install -y docker
service docker start
systemctl enable docker
usermod -aG docker ec2-user
