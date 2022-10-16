FROM alpine:latest

RUN apk update && apk upgrade
RUN apk add nginx \
        php8 \
        php8-fpm \
        php8-opcache \
        php8-gd \
        php8-zlib \
        php8-curl \
        php8-mysqli \
        php8-gettext \
        php8-zip \
        php8-json \
        php8-xsl \
        php8-pdo_mysql \
        php8-session \
        php8-xml \
        php8-simplexml \
        --no-cache
RUN mkdir -p /var/www/html && chown -R root:www-data /var/www/html

COPY server/etc/nginx /etc/nginx
COPY server/etc/php /etc/php8
COPY src /var/www/html
RUN mkdir /var/run/php
EXPOSE 80
EXPOSE 443

STOPSIGNAL SIGTERM

CMD sh -c "php-fpm8 && crond && chmod 777 /var/run/php/php8-fpm.sock && nginx -g 'daemon off;'"
