 # install docker to serevr
sudo apt-get -y install docker.io
 
 # download docker image from repository
sudo docker pull cloudera/quickstart:latest
  
 # print list of docker images - you need to take hash id
sudo docker images
 
 # create docker container from cloudera image and run it
sudo docker run --hostname=quickstart.cloudera --privileged=true -t -i -p 8888:8888 -p 21050:21050 -p 7180:7180 INSERT_HASH_CODE_HERE /usr/bin/docker-quickstart

# Start cloudera manager
sudo service cloudera-scm-server start
