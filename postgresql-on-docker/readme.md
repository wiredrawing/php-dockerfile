# postgresql on Docker コンテナで認証方法を指定したいとき
## dockerコマンドでコンテナ作成時に以下の用に指定する

```shell
docker container create  --name postgresql-12-2 \
    # ホスト機ポート:コンテナポート
    -p 5555:5432 \
    # superユーザー作成
    -e POSTGRES_USER=admin \
    # 上記で指定したユーザーのパスワード
    -e POSTGRES_PASSWORD=admin \
    # ユーザーの認証方式の指定
    -e POSTGRES_INITDB_ARGS="--auth-host=md5 --auth-local=md5" \
    postgres:12
```

**-e POSTGRES_INITDB_ARGSオプションを指定すること**

上記コマンドで作成したpostgresqlコンテナの
pg_hba.confファイルは以下のような設定で配置される

```ini
# 上記は省略
# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
local   all             all                                     md5
# IPv4 local connections:
host    all             all             127.0.0.1/32            md5
# IPv6 local connections:
host    all             all             ::1/128                 md5
# Allow replication connections from localhost, by a user with the
# replication privilege.
local   replication     all                                     md5
host    replication     all             127.0.0.1/32            md5
host    replication     all             ::1/128                 md5

host    all             all             all                     md5
```

上記の設定でロール作成コマンドを実行するとパスワードを聞かれる
```ini
root@18e81d7ed0ba:/# psql -U admin -c "create role someuser with login password 'someuser'"
Password for user admin:
CREATE ROLE
root@18e81d7ed0ba:/#

```

上記の用にたとえローカルホスト上の端末で操作中であっても認証パスワードを問われるようにしつつ
しかしバッチ処理などでrole作成処理などを自動化したい場合は以下のような隠しファイルを作成する


```.pgpass
# ホスト名:ポート名:DB名:ユーザー名:パスワード
localhost:5432:admin:admin:admin
```

上記のファイルをホームディレクトリに配置して再度
```ini
root@18e81d7ed0ba:/# psql -U admin -c "create role anything with login password 'anything'"
```
上記のようなコマンドを実行するとパスワードを聞かれることなくSQLの実行が完了する
