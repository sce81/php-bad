# PHP Bad App runtime (CVE-2024-2961: iconv buffer overflow fixed in PHP 8.1.28+)
FROM php:8.1.28-fpm

WORKDIR /var/www/html
COPY . /var/www/html
