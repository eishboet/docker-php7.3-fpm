FROM php:7.3-fpm

RUN apt-get update && apt-get install -y \
	libfreetype6-dev \
	libjpeg62-turbo-dev \
	libpng-dev \
	libicu-dev \
	libbz2-dev \
	exif \
	libgmp-dev \
	&& apt-get clean \
	&& docker-php-ext-configure gd --with-freetype-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install -j$(nproc) gd \
	&& docker-php-ext-configure intl \
	&& docker-php-ext-install intl \
	&& docker-php-ext-install bz2 \
	&& docker-php-ext-install exif \
	&& docker-php-ext-install gmp

VOLUME /usr/local/etc/
