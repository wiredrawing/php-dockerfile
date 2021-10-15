FROM php:5.6-apache


RUN apt-get update && apt-get install -y libpq-dev libjpeg-dev libpng-dev libgif-dev vim libicu-dev
RUN apt-get -y update && apt-get -y install libicu-dev libpng-dev libjpeg-dev libgif-dev vim libpq-dev libjpeg62-turbo-dev libmcrypt-dev \
&& docker-php-ext-install intl pdo pdo_pgsql pdo_mysql zip opcache mbstring iconv \
&& docker-php-ext-install mysqli \
&& docker-php-ext-install pgsql \
&& docker-php-ext-install mcrypt \
&& docker-php-ext-install mbstring \
&& docker-php-ext-install exif \
&& docker-php-ext-configure gd --with-jpeg-dir=/usr/include --with-png-dir=/usr/include \
&& docker-php-ext-install -j$(nproc) gd
RUN a2enmod rewrite

#ENTRYPOINT ["docker-php-entrypoint"]
WORKDIR /var/www/html
EXPOSE 80
CMD ["apache2-foreground"]
