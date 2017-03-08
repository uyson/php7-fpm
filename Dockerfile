FROM php:7.1-fpm

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
		supervisor \
#    && docker-php-ext-install -j$(nproc) iconv mcrypt pdo pdo_mysql mysqli gettext \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd iconv mcrypt pdo pdo_mysql mysqli gettext \
	&&  mkdir -p /var/log/supervisor
COPY php.ini /usr/local/etc/php/
