FROM alpine:latest

RUN apk update && apk upgrade
RUN apk add nginx \
        php82 \
        php82-fpm \
        php82-opcache \
        php82-gd \
        php82-zlib \
        php82-curl \
        php82-mysqli \
        php82-gettext \
        php82-zip \
        php82-json \
        php82-xsl \
        php82-pdo_mysql \
        php82-session \
        php82-xml \
        php82-simplexml \
        php82-ctype \
        php82-fileinfo \
        --no-cache
RUN mkdir -p /var/www/html && chown -R root:www-data /var/www/html

COPY server/etc/nginx /etc/nginx
COPY server/etc/php /etc/php8
##COPY src /var/www/html
RUN mkdir /var/run/php
EXPOSE 80
EXPOSE 443

STOPSIGNAL SIGTERM

RUN usermod -u 1000 nginx

CMD sh -c "php-fpm8 && crond && chmod 777 /var/run/php/php8-fpm.sock && nginx -g 'daemon off;'"
