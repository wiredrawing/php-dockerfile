

#　ローカル環境において開発用のpostgresqlサーバーをDockerで構築する


## postgresql用のボリュームを作成する

```

# 最新版のpostgresql-14をテスト構築するため
# postgresql-14という名前のボリュームを作成
docker volume create postgresql-14

```

## docker image からコンテナを作成する

```
docker container create --name postgresql-14 -v postgresql-14:/var/lib/postgresql/data -p 1234:5432 -e POSTGRES_PASSWORD=postgres postgres:14

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
