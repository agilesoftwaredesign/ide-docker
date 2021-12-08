FROM dorowu/ubuntu-desktop-lxde-vnc
# https://hub.docker.com/r/dorowu/ubuntu-desktop-lxde-vnc
#
# build: docker build -t ide-clion .
# 
# PowerShell: docker run -p 6080:80 -p 5900:5900 
#
# docker run -p 6080:80 -p 5900:5900 -e VNC_PASSWORD=mypassword --name ide ide-clion
# --> Browse http://127.0.0.1:6080/	
# --> OR use vncviewer on port 5900
# on linux docker run -p 6080:80 -p 5900:5900 -e VNC_PASSWORD=mypassword --name ide -v /dev/shm:/dev/shm ide-clion
### original docker run -p 6080:80 -p 5900:5900 -e VNC_PASSWORD=mypassword --name ide -v /dev/shm:/dev/shm dorowu/ubuntu-desktop-lxde-vnc

# add minimal support for installing bazel later on
RUN apt install curl gnupg &&\
  curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor > bazel.gpg &&\
  sudo mv bazel.gpg /etc/apt/trusted.gpg.d/ &&\
  echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list &&\
  mkdir /root/Desktop

# install some basic tools and libraries
RUN apt-get update &&\
  apt-get install --yes --no-install-recommends vim less build-essential git curl ncurses-dev mc libboost-all-dev g++ unzip zip bazel &&\
  rm -rf /var/cache/apt/

# install IDE CLion (by adding this file to the image, the start-up time increase by factor 3-5)
#COPY CLion.tar.gz /
# RUN curl curl --output CLion.tar.gz https://download-cdn.jetbrains.com/cpp/CLion-2021.2.tar.gz &&\
## RUN tar xzf /CLion.tar.gz -C /root &&\
##   rm -rf /CLion.tar.gz &&\
##   mkdir /root/Desktop &&\
##   ln -sf /root/*/bin/clion.sh /root/Desktop/clion.sh

COPY install-clion.sh /root/Desktop

EXPOSE 5900 80