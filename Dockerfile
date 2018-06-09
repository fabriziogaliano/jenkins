FROM jenkins/jenkins:2.126

LABEL maintainer "Fabrizio Galiano <fabrizio.galiano@hotmail.com>"

USER root

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

### INSTALL NODEJS LTS
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install nodejs

### INSTALL PYTHON 3.6
WORKDIR /tmp
RUN wget https://www.python.org/ftp/python/3.6.3/Python-3.6.3.tgz
RUN tar xvf Python-3.6.3.tgz
WORKDIR /tmp/Python-3.6.3
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

RUN curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose

WORKDIR /var/jenkins_home

EXPOSE 8080