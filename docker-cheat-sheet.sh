#!/usr/bin/env bash


#   Detach from alpine1 without stopping it by using the detach sequence,
#   CTRL + p CTRL + q (hold down CTRL and type p followed by q).

################  jump into container bash ################
docker exec -t -i <container_name>  /bin/bash

################  jump into container bash as root ################
docker exec --user="root" -it <container_name> /bin/bash

# exec into container found by label
docker exec --user="root" -it $(docker ps -aq --filter "label=webapp_id") /bin/bash


docker attach <container_name>



################  follow log ################
sudo docker logs -f <container_name or ID>

################  list all containers ################
docker container ls --all

################ List all containers (only IDs) ################
docker ps -aq

################ Stop all running containers. Using docker stop will send a SIG_HUP signal. ################
docker stop $(docker ps -a -q)

################ Remove all containers. After docker stop command ################
docker rm $(docker ps -aq)

################ Remove all containers using -f option (sends a SIG_KILL signal) ################
docker rm -vf $(docker ps -a -q)

################ Remove all containers except one  ################
docker rm -vf $(docker ps -a | grep -v "openam" | awk 'NR>1 {print $1}')

################################################################
######################### Remove images ###########################
################ Remove all images
docker rmi $(docker images -q)

################ Remove image
docker rmi quay.io/dockerinaction/ch3_hello_registry

################ Remove images condensed style
docker rmi \
  dockerinaction/ch3_myapp \
  dockerinaction/ch3_myotherapp \
  java:6

################ search docker images in default repository ################
docker search <search_pattern>

################################################################
################  Using alternative registries ################

# use alternative registry [REGISTRYHOST/][USERNAME/]NAME[:TAG]
docker pull quay.io/dockerinaction/ch3_hello_registry:latest

################  Images as files ################
#save image file from existing image
docker pull busybox:latest
docker save -o myfile.tar busybox:latest

################ load image from a file
docker load -i myfile.tar

################  Installing from a Dockerfile ################
git clone https://github.com/dockerinaction/ch3_dockerfile.git
docker build -t dia_ch3/dockerfile:latest ch3_dockerfile

################  jump into container bash ################
docker exec -t -i <container_name>  /bin/bash

################################################################################################################################
# Port forwardings can be specified ONLY with docker run command.
# Other commands, docker start does not have -p option and docker port only displays current forwardings.
# To add port forwardings, I always follow these steps,
# stop running container

docker stop test01

# commit the container
docker commit test01 test02

# NOTE: The above, test02 is a new image that I'm constructing from the test01 container.
# re-run from the commited image
docker run -p 8081:8080 -td test02

# Where the first 8081 is the local port and the second 8080 is the container port.

################################################################################################################################

################  Mount local folder ################
# Windows cmd
docker run -it --rm --name builder --volume %cd%:/home/project node:latest /bin/bash
docker run -it --rm --name builder --volume %cd%:/home/project node:latest ls -la /home/project

# Windows power shell
docker run -it --rm --name builder --volume ${PWD}:/home/project node:latest /bin/bash

# Linux via mount syntax
docker run -it \
  --rm \
  --name builder \
  --mount type=bind,source="$(pwd)"/,target=/home/project \
    node:latest \
    ls -la /home/project

################################################################################################################################
# check if container is running using metadata
docker inspect --format "{{.State.Running}}" <container_name>

# Get an instance’s IP address
docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' openam

# List all port bindings
docker inspect --format='{{range $p, $conf := .NetworkSettings.Ports}} {{$p}} -> {{(index $conf 0).HostPort}} {{end}}' openam

docker inspect --format "{{.Mounts}}" openam_local_config


docker stats my-nginx