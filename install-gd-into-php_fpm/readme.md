# dockerでGDライブラリ付きPHP-FPM環境を用意する

※注意)
ただしPHP7.4以降と PHP7.3以前で
GDライブラリインストール時のビルドオプションが異なる模様
ここではPHP7.4を対象にビルド手順を残す

## ベースのPHP-FPMコンテナを作成する

```
docker container create --name php-fpm php:7.4-fpm

docker container start php-fpm

docker container exec -it php-fpm bash
```


## GDライブラリのインストールに必要なライブラリをインストール

※参考例
https://tt-computing.com/docker-php-gd-summary


```
# php-gdに必要なツールを事前にインストールする
apt install libfreetype6-dev \
    libjpeg62-turbo-dev \
    libwebp-dev \
    libxpm-dev


# 上記インストール完了後
# --with-pngはデフォルト設定らしく当該オプションを認識しない...
docker-php-ext-configure gd \
    --with-jpeg \
    --with-freetype \
    --with-webp \
    --with-xpm

docker-php-ext-install -j$(nproc) gd
```
※ -j$(nproc)については以下を参照した
https://hacknote.jp/archives/27414/

## php -i コマンドでGDのインストール状況を確認する

上記までの手順が完了次第
php -i コマンドなどで以下のように出力されていればOk

```
....

gd

GD Support => enabled
GD Version => bundled (2.1.0 compatible)
FreeType Support => enabled
FreeType Linkage => with freetype
FreeType Version => 2.10.4
GIF Read Support => enabled
GIF Create Support => enabled
JPEG Support => enabled
libJPEG Version => 6b
PNG Support => enabled
libPNG Version => 1.6.37
WBMP Support => enabled
XPM Support => enabled
libXpm Version => 30411
XBM Support => enabled
WebP Support => enabled
BMP Support => enabled
TGA Read Support => enabled

Directive => Local Value => Master Value
gd.jpeg_ignore_warning => 1 => 1

....
```
