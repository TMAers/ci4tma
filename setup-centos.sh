#!/bin/sh

#export http_proxy=http://<proxy host IP>:<Port>
#export https_proxy=http://<proxy host IP>:<Port>
export CI4TMA_HOME=/opt/cpms
# Require to change to IP of your machine or FQDN
#export HOST_IP= <Host IP>
export HOST_IP= 192.168.88.220

sudo yum install -y docker

# sudo mkdir -p /etc/systemd/system/docker.service.d/
# APTFILE="/etc/systemd/system/docker.service.d/http-proxy.conf"

# /bin/cat <<EOM >$APTFILE
# [Service]
# Environment=HTTP_PROXY=<proxy host IP>:<Port>
# EOM

# sudo systemctl daemon-reload
# sudo service docker restart

sudo -E curl -L https://github.com/docker/compose/releases/download/1.15.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

docker-compose --version

sed -e 's,CI4TMA_HOME,'$CI4TMA_HOME',g' -i ./docker-compose.yml
sed -e 's,PHABRICATOR_HOST=HOST_IP,PHABRICATOR_HOST='$HOST_IP',g' -i ./docker-compose.yml

sudo mkdir -p $CI4TMA_HOME/phab/repos
sudo mkdir -p $CI4TMA_HOME/phab/extensions
sudo mkdir -p $CI4TMA_HOME/phab/mysql
sudo mkdir -p $CI4TMA_HOME/phab/sshkeys
sudo mkdir -p $CI4TMA_HOME/phab/filestore
sudo mkdir -p $CI4TMA_HOME/jenkins
sudo mkdir -p $CI4TMA_HOME/artifactory
sudo mkdir -p $CI4TMA_HOME/sonarqube/conf
sudo mkdir -p $CI4TMA_HOME/sonarqube/data
sudo mkdir -p $CI4TMA_HOME/sonarqube/extensions
sudo mkdir -p $CI4TMA_HOME/sonarqube/bundled-plugins
sudo mkdir -p $CI4TMA_HOME/sonarqube/postgresql
sudo mkdir -p $CI4TMA_HOME/sonarqube/postgresql/data

sudo chmod -R 777 $CI4TMA_HOME/phab/filestore
sudo chmod -R 777 $CI4TMA_HOME/phab/repos

sudo docker-compose up -d