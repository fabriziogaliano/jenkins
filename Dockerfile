FROM jenkins/jenkins:2.249.2-lts

LABEL maintainer "Fabrizio Galiano <fabrizio.galiano@hotmail.com>"

### Before upgrading pkgs version check everything!
ENV DOCKER_COMPOSE_VER 1.27.4
ENV PYTHON_VER 3.6.3
ENV NODE_VER 14

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
tk-dev \
pssh

### INSTALL NODEJS LTS [10] 20190629
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

### INSTALL Docker Compose
RUN curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VER}/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose

### Remove apt cache
RUN apt-get clean

### Install Jenkins custom plugins
RUN chmod +x /docker/configurations/jenkins/plugins.sh
RUN /docker/configurations/jenkins/plugins.sh

WORKDIR /var/jenkins_home

EXPOSE 8080
