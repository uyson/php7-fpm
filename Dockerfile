FROM php:5.2-fpm
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
    && pecl install memcache && pecl install memcached
RUN  echo extension=memcache.so >> /usr/local/etc/php/conf.d/memcache.ini
RUN echo extension=memcached.so >> /usr/local/etc/php/conf.d/memcached.ini
#RUN groupadd -g 501 www \
#       && useradd -g 501 -u 501 www \
#       && sed -i 's!www-data!www!g' /usr/local/etc/php-fpm.d/www.conf
#RUN usermod -u 501 www-data; groupmod -g 501 www-data

COPY php.ini /usr/local/etc/php/
