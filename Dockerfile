# svc-php-bad runtime image (PHP Bad App)
FROM php:8.1.28-fpm

WORKDIR /var/www/html
COPY . /var/www/html
