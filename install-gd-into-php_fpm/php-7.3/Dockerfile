# php7.3系最新版をベースにする
FROM php:7.3-fpm



RUN apt update && apt -y install \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libwebp-dev \
    libxpm-dev \
    libpq-dev \
    libzip-dev \
    zip \
    unzip \
    git \
    nodejs \
    ca-certificates \
    vim

# php7.3以前はGDライブラリ組み込み時のビルドオプションが異なる
RUN docker-php-ext-configure gd \
    --with-jpeg-dir \
    --with-png-dir \
    --with-webp-dir \
    --with-xpm-dir \
    --with-freetype-dir

RUN docker-php-ext-install -j$(nproc) gd opcache pdo_pgsql pdo_mysql zip

COPY --from=composer /usr/bin/composer /usr/bin/composer
