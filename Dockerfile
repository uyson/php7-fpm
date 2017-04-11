FROM php:5-fpm
COPY sources.list /etc/apt/sources.list
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libz-dev \
        libmemcached-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd iconv mcrypt pdo pdo_mysql mysqli gettext opcache \
    && pecl install memcache-3.0.8 && pecl install memcached-2.2.0 \
    && echo extension=memcache.so >> /usr/local/etc/php/conf.d/memcache.ini \
    && echo extension=memcached.so >> /usr/local/etc/php/conf.d/memcached.ini
#RUN groupadd -g 501 www \
#       && useradd -g 501 -u 501 www \
#       && sed -i 's!www-data!www!g' /usr/local/etc/php-fpm.d/www.conf


COPY php.ini /usr/local/etc/php/
