FROM php:5.6-apache


RUN apt-get update && apt-get install -y libpq-dev libjpeg-dev libpng-dev libgif-dev vim libicu-dev
RUN docker-php-ext-configure gd --with-jpeg-dir=/usr/include --with-png-dir=/usr/include && docker-php-ext-install gd opcache pgsql pdo_pgsql mysql pdo_mysql intl

RUN a2enmod rewrite

#ENTRYPOINT ["docker-php-entrypoint"]
WORKDIR /var/www/html
EXPOSE 80
CMD ["apache2-foreground"]
