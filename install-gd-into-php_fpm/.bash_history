apt update 
cd ~ 
ls
php -i > before.php-info 
apt install libfreetype6-deb libjpeg62-turbo-dev libwebp-dev
apt install libfreetype6-dev libjpeg62-turbo-dev libwebp-dev libxpm-dev
docker-php-ext-configure gd --with-jpeg --with-png --with-freetype --with-webp --with-xpm
docker-php-ext-configure gd --with-jpeg --with-freetype --with-webp --with-xpm
docker-php-ext-install -j$(nproc) gd
php -i | grep gd
php -i > after.php-info 
exit
