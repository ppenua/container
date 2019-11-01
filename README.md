# container

#### 介绍
docker-compose 管理的多容器服务 （nginx+php+mysql+redis）

#### 安装教程
非 `root` 用户启动 需要修改 `.env` 
```shell
#### 进程用户
PROCESS_USER_NAME=user
PROCESS_USER_ID=501
PROCESS_GROUP_NAME=staff
PROCESS_GROUP_ID=250
```
否则会产生 写权限问题

`docker-compose up -d`

#### windows
修改 php/Dockerfile 中  

`sh install.sh && \` -> `dos2unix && sh install.sh &&\`

#### 使用 composer
已经集成在 `php` 容器内
```
curl -sS https://getcomposer.org/installer | php && \
mv composer.phar /usr/local/bin/composer && \
```

#### 添加快捷指令
在 ~/.bash_profile 文件中加上  
`alias dphp='docker exec -it php-fpm /bin/sh'`  

执行
`source .bash_profile`

