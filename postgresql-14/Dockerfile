# ------------------------------------------------------
# 本ファイルを使用してイメージを作成し
# コンテナ作成時に  -e POSTGRES_PASSWORD=something という
# オプションを必ず指定する
# 例)docker container create --name postgresql-14 -v postgresql-14:/var/lib/postgresql/data \
# -p 5555:5432 \
# -e POSTGRE_USER=admin \
# -e POSTGRES_PASSWORD=10574318 \
# -e POSTGRES_HOST_AUTH_METHOD=md5 pg14
# ------------------------------------------------------

# postgresqlバージョン12をベースとする
FROM postgres:14




# admin名 superuserアカウントをを作成する
RUN echo "postgresql-14のビルドを実行開始 ------------------------------->"

# 基本コマンドをインストール
RUN apt update && apt install -y procps

#USER postgres

# 作成するpostgresql-14サーバーに対して行ってほしい処理
# 初期化スクリプトをcopy(※初期化スクリプトはinitという文字列を必ずつけておく)
COPY  init.sh /docker-entrypoint-initdb.d/

EXPOSE 5432
