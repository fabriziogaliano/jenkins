FROM jenkins/jenkins:2.126

LABEL maintainer "Fabrizio Galiano <fabrizio.galiano@hotmail.com>"

### Before upgrading pkgs version check everything!
ENV DOCKER_COMPOSE_VER 1.21.2
ENV PYTHON_VER 3.6.3
ENV NODE_VER 8

USER root

### Copy configurations folder inside container
COPY docker docker

RUN apt-get update && apt-get install -y \
apt-transport-https \
ca-certificates \
curl \
gnupg2 \
software-properties-common \
wget \
make \
expect \
build-essential \
libssl-dev \
zlib1g-dev \
libbz2-dev \
libreadline-dev \
libsqlite3-dev \
llvm \
libncurses5-dev \
libncursesw5-dev \
xz-utils \
tk-dev

### INSTALL NODEJS LTS [8] 09062018
RUN curl -sL https://deb.nodesource.com/setup_${NODE_VER}.x | bash -
RUN apt-get install nodejs

### INSTALL PYTHON 3.6
WORKDIR /tmp
RUN wget https://www.python.org/ftp/python/${PYTHON_VER}/Python-${PYTHON_VER}.tgz
RUN tar xvf Python-${PYTHON_VER}.tgz
WORKDIR /tmp/Python-${PYTHON_VER}
RUN ./configure --enable-optimizations --with-ensurepip=install
#RUN make -j8
RUN make altinstall

RUN python3.6 --version
RUN pip3.6 --version

RUN pip3.6 install --upgrade setuptools

### INSTALL DOCKER-CE
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
"deb [arch=amd64] https://download.docker.com/linux/debian \
$(lsb_release -cs) \
stable"
RUN apt-get update
RUN apt-get install -y docker-ce

RUN curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VER}/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose

### Install Jenkins custom plugins
RUN cp /docker/configurations/jenkins/plugins.sh


### Copy the expect script for npm login (for private registry)
RUN mkdir -p /var/jenkins_home/assets
RUN cp /docker/configurations/npm/npmlogin.sh /var/jenkins_home/assets
RUN chmod +x /var/jenkins_home/assets/npmlogin.sh

WORKDIR /var/jenkins_home

EXPOSE 8080