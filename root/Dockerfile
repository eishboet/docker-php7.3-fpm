FROM php:7.3-fpm

ENV PHPREDIS_VERSION=5.2.1

ADD https://github.com/phpredis/phpredis/archive/${PHPREDIS_VERSION}.tar.gz /tmp/
RUN apt-get update && apt-get install -y \
	&& apt-get clean \
	&& cp /usr/local/etc/php/php.ini-production $PHP_INI_DIR/php.ini \
	&& pecl config-set php_ini $PHP_INI_DIR \
	&& docker-php-ext-configure gd --with-freetype-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install -j$(nproc) gd \
	&& docker-php-ext-configure intl \
	&& docker-php-ext-install intl \
	&& docker-php-ext-install bz2 \
	&& docker-php-ext-install exif \
	&& docker-php-ext-install gmp \
	&& docker-php-ext-install pdo_mysql \
	&& docker-php-ext-install mysqli \
	&& docker-php-ext-enable pdo_mysql \
	&& docker-php-ext-install zip \
	&& tar xzf /tmp/${PHPREDIS_VERSION}.tar.gz -C /tmp/ \
  && rm -r /tmp/${PHPREDIS_VERSION}.tar.gz \
	&& mkdir -p /usr/src/php/ext /www \
	&& mv /tmp/phpredis-${PHPREDIS_VERSION} /usr/src/php/ext/redis \
  && docker-php-ext-install redis \
	&& pecl install apcu \
	&& sed -i 's#;chroot =#chroot = /www#' /usr/local/etc/php-fpm.d/www.conf

VOLUME /usr/local/etc /www
