# DockerMySqlNodeAdminer

![APM](https://img.shields.io/apm/l/vim-mode?color=green&label=license&logo=mit&logoColor=mit&style=for-the-badge&logo=appveyor)
![Badge](https://img.shields.io/static/v1?label=javascript&message=tools&color=red&flat&logo=PYTHON&style=for-the-badge&logo=appveyor)
![Badge](https://img.shields.io/static/v1?label=node.js&message=framework&color=yellowgreen&flat&logo=PYTHON&style=for-the-badge&logo=appveyor)

# How to use

## Requirements

- [Docker](https://www.docker.com/)
- [Docker-compose](https://docs.docker.com/compose/install/)

## Install
``` 
cd DockerMySqlNodeAdminer/
docker-compose up -d --build mysql
docker-compose up -d --build adminer
docker-compose up --build backend
```

## After change on Node
``` 
docker-compose up --build backend
```

## Adminer
http://localhost:8080/

- server: mysql
- username: root
- password: RootPassword
- database: Company

## Quote

> [1] FALOURD, Guillaume. **Um pouco de Docker na prática**.(2022) https://www.zup.com.br/blog/docker-na-pratica?utm_source=google-chat&utm_medium=interno&utm_campaign=gc-geral%E2%80%A6

> [2] LIMA, Tiago. **Criando uma API RESTful com NodeJS e Express — Inicializando o projeto e o método GET**. (2019) https://medium.com/xp-inc/https-medium-com-tiago-jlima-developer-criando-uma-api-restful-com-nodejs-e-express-9cc1a2c9d4d8