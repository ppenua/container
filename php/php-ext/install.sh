#!/bin/sh

######################### already compiled into the image #############################
#### Core, ctype, curl, date, dom, fileinfo, filter, ftp, hash, iconv, json        ####
#### libxml, mbstring, mysqlnd, openssl, pcre, PDO, pdo_sqlite, Phar, posix        ####
#### readline, Reflection, session, SimpleXML, sodium, SPL, sqlite3, standard      ####
#### tokenizer, xml, xmlreader, xmlwriter, zlib                                    ####
#######################################################################################

#########################  Core Extensions  ###########################################
#### bcmath, calendar, exif, gettext, sockets, dba                                 ####
#### mysqli, pcntl, pdo_mysql, shmop, sysvmsg, sysvsem, sysvshm                    ####
####                                                                               ####
#### RUN docker-php-ext-install -j$(nproc) bcmath                                  ####
#### RUN apt-get update && apt-get install -y \                                    ####
####     		libfreetype6-dev \                                                 ####
####     		libjpeg62-turbo-dev \                                              ####
####     		libpng-dev \                                                       ####
####     	&& docker-php-ext-install -j$(nproc) iconv \                           ####
####     	&& docker-php-ext-configure gd \                                       ####
####     	   --with-freetype-dir=/usr/include/ \                                 ####
####     	   --with-jpeg-dir=/usr/include/ \                                     ####
####     	&& docker-php-ext-install -j$(nproc) gd                                ####
#######################################################################################


if [ -n "$PHP_CORE_EXT" ]; then
    echo "---------------------install CORE-EXTENSIONS ---------------------"
    echo $PHP_CORE_EXT
    apk add --no-cache gettext-dev
    docker-php-ext-install -j$(nproc) $PHP_CORE_EXT
fi

#########################  Other Extensions  ##########################################

echo "---------------------install Other-EXTENSIONS ---------------------"
apk add --no-cache autoconf g++ make re2c

if [ -z "${PHP_OTHER_EXT##* bz2 *}" ]; then
    apk --no-cache add bzip2-dev && \
    docker-php-ext-install -j$(nproc) bz2
fi

if [ -z "${PHP_OTHER_EXT##* gd *}" ]; then
    apk add --no-cache freetype-dev libjpeg-turbo-dev libpng-dev && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install -j$(nproc) gd
fi

if [ -z "${PHP_OTHER_EXT##* zip *}" ]; then
    apk add --no-cache libzip-dev && \
    docker-php-ext-configure zip --with-libzip && \
    docker-php-ext-install -j$(nproc) zip
fi

if [ -z "${PHP_OTHER_EXT##* mcrypt *}" ]; then
    apk add --no-cache libmcrypt-dev && \
    mkdir mcrypt && \
    tar -xf mcrypt-1.0.2.tgz -C mcrypt --strip-components=1 && \
    ( cd mcrypt && phpize && ./configure && make && make install ) && \
    docker-php-ext-enable mcrypt
fi

if [ -z "${PHP_OTHER_EXT##* redis *}" ]; then
    mkdir redis && \
    tar -xf redis-5.0.0.tgz -C redis --strip-components=1 && \
    ( cd redis && phpize && ./configure && make && make install ) && \
    docker-php-ext-enable redis
fi

if [ -z "${PHP_OTHER_EXT##* memcached *}" ]; then
    apk add --no-cache zlib-dev libmemcached-dev && \
    mkdir memcached && \
    tar -xf memcached-3.1.3.tgz -C memcached --strip-components=1 && \
    ( cd memcached && phpize && ./configure && make && make install ) && \
    docker-php-ext-enable memcached
fi

if [ -z "${PHP_OTHER_EXT##* mongodb *}" ]; then
    mkdir mongodb && \
    tar -xf mongodb-1.5.5.tgz -C mongodb --strip-components=1 && \
    ( cd mongodb && phpize && ./configure && make && make install ) && \
    docker-php-ext-enable mongodb
fi

if [ -z "${PHP_OTHER_EXT##* xdebug *}" ]; then
    mkdir xdebug && \
    tar -xf xdebug-2.8.0.tgz -C xdebug --strip-components=1 && \
    ( cd xdebug && phpize && ./configure && make && make install ) && \
    docker-php-ext-enable xdebug
fi


