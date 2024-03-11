FROM composer:2.6.6 as composer

WORKDIR /app
COPY ./composer.json /app
COPY ./composer.lock /app

RUN composer install --no-dev

FROM php:8.3.2-apache
RUN apt udate\
 && apt install wget\
 && rm -rf /var/lib/apt/lists/*
RUN a2enmod rewrite

WORKDIR /var/www/html/
COPY ./ /var/www/html/
RUN mkdir -p ./tmp/compile/ && chmod -R 777 ./tmp/compile/
COPY --from=composer /app/vendor ./vendor
