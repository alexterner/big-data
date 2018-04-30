# Ubuntu Install Docker 
sudo apt-get -y install docker.io
 
# Centos Install Docker 
yum install -y docker
 
# Disable firewall
systemctl stop firewalld
 
# Enable login as Root
sudo -i 
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sed -i 's/PermitRootLogin no/PermitRootLogin yes/g' /etc/ssh/sshd_config
sudo service sshd restart
  
sudo passwd root 

# Start docker server 
systemctl start docker
 
# Start kafka container
docker run --rm -it \
           -p 2181:2181 -p 3030:3030 -p 8081:8081 \
           -p 8082:8082 -p 8083:8083 -p 9092:9092 \
           -e ADV_HOST=127.0.0.1 \
           landoop/fast-data-dev
