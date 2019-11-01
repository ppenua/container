ARG PHP_IMAGE
FROM ${PHP_IMAGE}

ARG ALPINE_REPOSITORIES
ARG PHP_CORE_EXT
ARG PHP_OTHER_EXT
ARG TIMEZONE
ARG PHP_FPM_USER
ARG PHP_FPM_USER_ID
ARG PHP_FPM_GROUP
ARG PHP_FPM_GROUP_ID

COPY ./php-ext /tmp/php-ext
WORKDIR /tmp/php-ext

ENV PHP_OTHER_EXT = " ${PHP_OTHER_EXT} "

RUN if [ -n "$ALPINE_REPOSITORIES" ]; then \
            sed -i "s/dl-cdn.alpinelinux.org/${ALPINE_REPOSITORIES}/g" /etc/apk/repositories; \
    fi && \
    if [ -n "$PHP_FPM_USER" ]; then \
        addgroup "$PHP_FPM_GROUP" -g "$PHP_FPM_GROUP_ID" && \
        adduser "$PHP_FPM_USER" -D -G "$PHP_FPM_GROUP" -u "$PHP_FPM_USER_ID"; \
    fi && \
    apk update && apk --no-cache add tzdata && \
    cp "/usr/share/zoneinfo/$TIMEZONE" /etc/localtime && \
    echo "$TIMEZONE" > /etc/timezone && \
    curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    chmod +x install.sh && \
    sh install.sh && \
    rm -rf /tmp/php-ext

WORKDIR /usr/local/www

