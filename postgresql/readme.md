

# ローカル環境において開発用のpostgresqlサーバーをDockerで構築する


## postgresql用のボリュームを作成する

```

# 最新版のpostgresql-14をテスト構築するため
# postgresql-14という名前のボリュームを作成
docker volume create postgresql-14

```

## docker image からコンテナを作成する

```
# 旧来の -vオプションを利用した場合
docker container create --name postgresql-14  \
-v postgresql-14:/var/lib/postgresql/data \
-p 1234:5432 \
-e POSTGRES_PASSWORD=postgres postgres:14

# 新しい --mount type=~コマンドを利用した場合
# --mountコマンドのtypeオプションにvolumeを指定する
docker container create --name test-postgresql-14 \
--mount type=volume,src=test-postgresql-14,dst=/var/lib/postgresql/data \
-p 2234:5432 \
-e POSTGRES_PASSWORD=postgres postgres:14

# 上記コマンドを実行してコンテナを作成

docker container ls -a

# 上記コマンドでpostgresql-14の作成を確認する

```

## 作成したpostgresql-14のコンテナに入る

```

docker container exec -it postgresql-14 bash


# ログイン後 psqlコマンドを使ってpostgresqlにログイン

psql -U postgres

# 更に汎用的に使う superuser権限のアカウントを作成する

create role admin with superuser login password 'admin';

# \du コマンドで作成済みユーザーを確認できる

```

## 作成した admin アカウントで ホストOS側のクライアントでログインできるか検証する

**上記の方法でpostgresql-11 ~ postgresql-13まで同様にコンテナを作成できる**


## 作成済みのpostgresqlアカウントのパスワードを変更する

```
# 指定したユーザーのパスワードを変更する

alter user admin with password 'something';

```

## psql コマンドで非インタラクティブにSQL文を実行する

```

# psqlコマンドで SQL文を実行する
# create role 文
psql -c " create role admin with superuser login password 'admin';"

# 実行ユーザを指定する場合
psql -U postgres -c " create role admin with superuser login password 'admin'"

# 実行ユーザのパスワードを変更する場合
psql -U postgres -c " alter role admin with password 'admin' ";


```

## 作成したpostgres dockerコンテナの時間をJSTに変更する

```
# 本dockerコンテナはDebianであることを前提
# dateコマンドで現在のタイムゾーンを調べる

date
# Tue 26 Apr 2022 02:21:47 AM UTC

```

上記のようにUTCタイムとなっているのでこれをJSTに変更する

```
root@1901b0bfa9fd:/# ls -al /etc/localtime
lrwxrwxrwx 1 root root 27 Mar 16 00:00 /etc/localtime -> /usr/share/zoneinfo/Etc/UTC

```
現在のタイムゾーンファイルがUTCを参照しているので
これをAsia/Tokyoに変更する


```
# 現状のタイムゾーンファイルのバックアップを取る
cp /etc/localtime /etc/localtime.backup


ls -a /usr/share/zoneinfo

.           Atlantic   Cuba     Europe   GMT0       iso3166.tab        Libya      NZ          PRC        tzdata.zi  zone1970.tab
..          Australia  EET      Factory  Greenwich  Israel             localtime  NZ-CHAT     PST8PDT    UCT        zone.tab
Africa      Brazil     Egypt    GB       Hongkong   Jamaica            MET        Pacific     right      Universal  Zulu
America     Canada     Eire     GB-Eire  HST        Japan              Mexico     Poland      ROC        US
Antarctica  CET        EST      GMT      Iceland    Kwajalein          MST        Portugal    ROK        UTC
Arctic      Chile      EST5EDT  GMT+0    Indian     leapseconds        MST7MDT    posix       Singapore  WET
Asia        CST6CDT    Etc      GMT-0    Iran       leap-seconds.list  Navajo     posixrules  Turkey     W-SU

```
上記のタイムゾーンファイル一覧にJapanがあるのでシンボリックリンクを貼る


```
# シンボリックリンクを貼るコマンド
ln -sf /usr/share/zoneinfo/Japan /etc/localtime

# コマンドを実行して JST になっていることを確認する
date
Tue 26 Apr 2022 11:26:32 AM JST


```

ちなみに

```
# 以下を実行すると
ls -al  /usr/share/zoneinfo/Japan

# lrwxrwxrwx 1 root root 10 Oct 26 02:14 /usr/share/zoneinfo/Japan -> Asia/Tokyo

```
上記の用に

/usr/share/zoneinfo/Asia/Tokyo => /usr/share/zoneinfo/Japan
シンボリックリンクがはられているのが確認できる


## コマンドラインで psqlコマンド実行時にパスワードを省略したい

**ホームディレクトリに.pgpassという隠しファイルを作成する**
