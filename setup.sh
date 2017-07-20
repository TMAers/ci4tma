#!/bin/sh

export http_proxy=http://<proxy host IP>:<Port>
export https_proxy=http://<proxy host IP>:<Port>
export CPMS_HOME=/opt/cpms
# Require to change to IP of your machine or FQDN
export HOST_IP= <Host IP>

APTFILE="/etc/apt/apt.conf.d/10proxy"

/bin/cat <<EOM >$APTFILE
Acquire::http::Proxy "http://<proxy host IP>:<Port>";
EOM

sudo apt update
sudo apt -y install curl
sudo apt -y install docker.io

sudo mkdir -p /etc/systemd/system/docker.service.d/
APTFILE="/etc/systemd/system/docker.service.d/http-proxy.conf"

/bin/cat <<EOM >$APTFILE
[Service]
Environment=HTTP_PROXY=<proxy host IP>:<Port>
EOM

sudo systemctl daemon-reload
sudo service docker restart

sudo -E curl -L "https://github.com/docker/compose/releases/download/1.11.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

docker-compose --version

sed -e 's,CPMS_HOME,'$CPMS_HOME',g' -i ./docker-compose.yml
sed -e 's,PHABRICATOR_HOST=HOST_IP,PHABRICATOR_HOST='$HOST_IP',g' -i ./docker-compose.yml

sudo mkdir -p $CPMS_HOME/phab/repos
sudo mkdir -p $CPMS_HOME/phab/extensions
sudo mkdir -p $CPMS_HOME/phab/mysql
sudo mkdir -p $CPMS_HOME/phab/sshkeys
sudo mkdir -p $CPMS_HOME/phab/filestore
sudo mkdir -p $CPMS_HOME/jenkins
sudo mkdir -p $CPMS_HOME/artifactory
sudo mkdir -p $CPMS_HOME/sonarqube/conf
sudo mkdir -p $CPMS_HOME/sonarqube/data
sudo mkdir -p $CPMS_HOME/sonarqube/extensions
sudo mkdir -p $CPMS_HOME/sonarqube/bundled-plugins
sudo mkdir -p $CPMS_HOME/sonarqube/postgresql
sudo mkdir -p $CPMS_HOME/sonarqube/postgresql/data

sudo chmod -R 777 $CPMS_HOME/phab/filestore
sudo chmod -R 777 $CPMS_HOME/phab/repos

sudo docker-compose up -d