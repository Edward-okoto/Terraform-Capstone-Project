#!/bin/bash
# Update all packages
yum update -y

# Install Apache HTTP server
yum install -y httpd

# Start the HTTP server
systemctl start httpd

# Enable the HTTP server to start at boot
systemctl enable httpd

# Create a simple test HTML file
echo "<html><body><h1>Welcome to Apache HTTP Server on EC2!</h1></body></html>" > /var/www/html/index.html