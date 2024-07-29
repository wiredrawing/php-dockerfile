# PHP 7.3系をhttpd(apacheで動作させる)
# 当該のDockerfileからコンテナのイメージを作成する
# docker build -t PHP-7.3-apache(任意の名前) .(ドット Dockerfileのあるディレクト)
# 作成した新規コンテナイメージ名を<php-7.3-apache>とする

# 新規コンテナの作成方法
# docker container create --name php-7.3-apache --mount type=bind,source='C:/Users/a-sen/works/my-project/public',destination=/var/www/html/ -p 8080:80 php-7.3-apache
# ※参考URL) https://blog.amedama.jp/entry/docker-mount-volume

FROM php:7.3-apache

# Composerのインストール
RUN cd /usr/bin && curl -s http://getcomposer.org/installer | php && ln -s /usr/bin/composer.phar /usr/bin/composer

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
#    libffi-dev\
    libgmp-dev \
    libtidy-dev \
    vim \
    unzip \
    nodejs \
    ca-certificates \
    zip

# GDライブラリのビルドオプション
# 当該ライブラリのオプションはPHP7.3系までとPHP7.4系以降で
# 指定方法が異なることに注意する
RUN docker-php-ext-configure gd \
                --with-freetype-dir=/usr/include/ \
                --with-jpeg-dir=/usr/include/ \
                --with-webp-dir=/usr/include/


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
#    ffi \
    tidy

# ------------------------------------------------------------
# ImageMagick をインストールする
# ------------------------------------------------------------
RUN apt -y install imagemagick libmagickwand-dev && \
    pecl install imagick &&  \
    docker-php-ext-enable imagick



# apache mod_rewriteの有効化
RUN a2enmod rewrite

WORKDIR /var/www
EXPOSE 80
CMD ["apache2ctl", "-D", "FOREGROUND"]
