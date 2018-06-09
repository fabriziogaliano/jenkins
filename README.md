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

# some screenshot to help configure jenkins properly

![1](https://user-images.githubusercontent.com/22646600/41192696-0c910b04-6c02-11e8-99f8-ce4917987e26.JPG)

![2](https://user-images.githubusercontent.com/22646600/41192705-208ff836-6c02-11e8-9775-ac3828567cfc.JPG)

![3](https://user-images.githubusercontent.com/22646600/41192707-26d8652a-6c02-11e8-88a0-e5a3cd2e6b5d.JPG)

![4](https://user-images.githubusercontent.com/22646600/41192708-26f7771c-6c02-11e8-9601-c2105e5d76cd.JPG)

![5](https://user-images.githubusercontent.com/22646600/41192709-2715ffca-6c02-11e8-926d-f680b6572934.JPG)

# Enjoy it