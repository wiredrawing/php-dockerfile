# wordpress自体はapacheで動作させる
FROM php:8.1-apache

# Composerのインストール

# cd コマンドより WORKDIR の方が良い
WORKDIR /usr/bin
RUN curl -s http://getcomposer.org/installer | php && ln -s /usr/bin/composer.phar /usr/bin/composer
#RUN cd /usr/bin && curl -s http://getcomposer.org/installer | php && ln -s /usr/bin/composer.phar /usr/bin/composer


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

# ------------------------------------------------------------
# ImageMagick をインストールする
# ------------------------------------------------------------
RUN apt -y install imagemagick libmagickwand-dev && \
    pecl install imagick &&  \
    docker-php-ext-enable imagick



# apache mod_rewriteの有効化
RUN a2enmod rewrite

WORKDIR /var/www/html
EXPOSE 80
CMD ["apache2ctl", "-D", "FOREGROUND"]
