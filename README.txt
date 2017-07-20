CONTENTS
  I. INTRODUCTION
  I. SYSTEM REQUIREMENTS
III. INSTALLATION

I. INTRODUCTION
This project is based on Docker which help you quickly start set of tools 
currently including Phabricator (https://www.phacility.com/phabricator), 
Jenkins (https://jenkins.io), Artifactory (https://www.jfrog.com/artifactory),
Sonarqube (https://www.sonarqube.org).

II. SYSTEM REQUIREMENTS
- Supported operating systems: Ubuntu 16.
- Recommended hardware configuration:
    + RAM 4GB  (or more)
    + CPU Core i5 (or higher)
    + HDD 20GB (or more)

III. INSTALLATION
- Before installing, you must configure DNS for your machine to resolve tma domain
and ensure internet connectivity during installation time.
- Change value of variables in setup.sh file: CPMS_HOME (line 5) and HOST_IP (line 7) to appropriate values.
- Transfer files: setup.sh, docker-compose.yml to your machine then run below commands:
    sudo chmod 755 ./setup.sh
    sudo ./setup.sh

After a few minutes, the installation process completes successfully, you can access:
Phabricator: http://YOUR_HOST_IP_ADDRESS
Jenkins: http://YOUR_HOST_IP_ADDRESS:8080
Artifactory: http://YOUR_HOST_IP_ADDRESS:8081
Sonarqube: http://YOUR_HOST_IP_ADDRESS:9000
