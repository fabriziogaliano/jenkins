# jenkins
[![](https://images.microbadger.com/badges/version/fabriziogaliano/jenkins.svg)](https://microbadger.com/images/fabriziogaliano/jenkins "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/fabriziogaliano/jenkins.svg)](https://microbadger.com/images/fabriziogaliano/jenkins "Get your own image badge on microbadger.com")


# Jenkins docker image with docker-python-node-npm preinstalled for Pipeline

Images Ready-To-Go to use Jenkins Pipeline Plugin ;) --- you can find the jenkinsfile inside this repo

Ovverride the docker-compose config with your own information:
```
version: '3'

networks:
  default:
    external:
      name: public

services:
  jenkins:
    image: fabriziogaliano/jenkins

    restart: always

    container_name: jenkins

    user: root

    tty: true

    volumes:
      - /root/.ssh:/root/.ssh
      - ./data:/var/jenkins_home
      - /var/run/docker.sock:/var/run/docker.sock

    environment:
      JAVA_OPT: "JAVA_OPT=-Xmx512m -Dhudson.footerURL=https://ci.example.it"

    ports:
      - 80:8080

```