FROM php:7.3-fpm

RUN rm "$PHP_INI_DIR/php.ini" "/usr/local/etc/php-fpm.d/www.conf"
