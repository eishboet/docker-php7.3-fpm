FROM php:7.3-fpm
LABEL maintainer="Deanen Perumal"
ENV DEBIAN_FRONTEND=noninteractive
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && sync && apt-get update && apt-get -y upgrade && apt-get install -yqq \
apt-utils \
libfreetype6-dev \
libjpeg62-turbo-dev \
libpng-dev \
libwebp-dev \
libcurl4-gnutls-dev \
libxml2-dev \
openssl \
libzip-dev \
zlib1g-dev \
libpq-dev \
libc-client2007e-dev \
krb5-config \
libkrb5-dev \
libldap2-dev \
libgmp-dev \
libsmbclient \
libsmbclient-dev \
imagemagick \
libmagickwand-dev \
libbz2-dev \
libmemcached-dev \
zlib1g-dev \
&& apt-get -yqq clean \
&& docker-php-ext-configure gd --with-freetype-dir=/usr/lib --with-jpeg-dir=/usr/lib --with-png-dir=/usr/lib --with-webp-dir=/usr/lib \
&& docker-php-ext-install -j$(nproc) gd \
&& docker-php-ext-configure intl \
&& docker-php-ext-install intl \
&& docker-php-ext-configure bz2 --with-bz2 \
&& docker-php-ext-install bz2 \
&& docker-php-ext-install zip \
&& docker-php-ext-install pdo_mysql \
&& docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
&& docker-php-ext-install imap \
&& docker-php-ext-install ldap \
&& docker-php-ext-install exif \
&& docker-php-ext-install gmp \
&& docker-php-ext-install pcntl \
&& pecl install redis-5.3.3 \
&& pecl install smbclient \
&& pecl install imagick \
&& pecl install apcu \
&& pecl install memcached-3.1.4 \
&& docker-php-ext-enable redis smbclient imagick apcu memcached \
&& mkdir -p /config
&& ln -s /config/* /usr/local/etc/
VOLUME /config
STOPSIGNAL SIGQUIT
EXPOSE 9000
CMD ["php-fpm"]
