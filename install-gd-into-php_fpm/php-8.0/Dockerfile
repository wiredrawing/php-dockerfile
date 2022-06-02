# php8.0系をベースにビルドする

FROM php:8.0-fpm

RUN apt update && apt -y install  libzip-dev \
    libpq-dev \
    git \
    nodejs \
    zip \
    unzip \
    ca-certificates \
    vim \
    libfreetype6-dev \
    libjpeg-dev \
    libwebp-dev \
    libxpm-dev \
    libssl-dev




RUN docker-php-ext-configure gd \
    --with-jpeg \
    --with-webp \
    --with-xpm \
    --with-freetype



RUN docker-php-ext-install -j$(nproc) gd  \
    opcache  \
    pdo_pgsql  \
    pdo_mysql \
    mysqli \
    zip \
    ftp \
    sockets

COPY --from=composer /usr/bin/composer /usr/bin/composer
