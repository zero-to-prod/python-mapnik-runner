#!/bin/bash

# Check if the user is root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 
   exit 1
fi

# Update package list and install prerequisites
sudo apt-get update
sudo apt-get install -y ca-certificates curl git


# Set up Docker's official GPG key and repository
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add Docker repository to Apt sources
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package list and install Docker Engine and Docker Compose
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose

# Clone your project repository
git clone [YOUR_PROJECT_GIT_URL] /opt/my-mapnik-project
cd /opt/my-mapnik-project

# Build the Docker image
sudo docker-compose build

# Create a global shell script
cat <<EOF > /usr/local/bin/run-mapnik
#!/bin/bash
cd /opt/my-mapnik-project
./run.sh \$1
EOF

# Make the script executable
chmod +x /usr/local/bin/run-mapnik

echo "Installation completed. You can now use 'run-mapnik <filename>' to run your project."
