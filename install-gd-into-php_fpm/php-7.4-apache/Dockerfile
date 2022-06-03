# wordpress自体はapacheで動作させる
FROM php:7.4-apache

# PHPの拡張に必要なライブラリ
RUN apt update && apt install -y  libpng-dev  \
    libjpeg62-turbo-dev  \
    libfreetype6-dev  \
    libgif-dev \
    libwebp-dev \
    libxpm-dev \
    libzip-dev \
    libpq-dev \
    libssl-dev \
    libffi-dev\
    libgmp-dev \
    libtidy-dev \
    vim \
    unzip \
    nodejs \
    ca-certificates \
    zip

# GDライブラリのビルドオプション
RUN docker-php-ext-configure gd \
    --with-jpeg \
    --with-webp \
    --with-xpm \
    --with-freetype



# PHPの拡張をビルド
RUN docker-php-ext-install -j$(nproc) gd  \
    opcache \
    pdo \
    pdo_pgsql  \
    pdo_mysql \
    mysqli \
    zip \
    ftp \
    sockets \
    exif \
    gmp \
    bcmath \
    ffi \
    tidy



# apache mod_rewriteの有効化
RUN a2enmod rewrite

WORKDIR /var/www/html
EXPOSE 80
CMD ["apache2ctl", "-D", "FOREGROUND"]
