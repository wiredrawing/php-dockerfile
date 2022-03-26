
# postgresqlバージョン12をベースとする
FROM postgres:14




# admin名 superuserアカウントをを作成する
RUN echo "postgresql-12のビルドを実行開始 ------------------------------->"

#USER postgres

# 作成するpostgresql-14サーバーに対して行ってほしい処理
# 初期化スクリプトをcopy(※初期化スクリプトはinitという文字列を必ずつけておく)
COPY  init.sh /docker-entrypoint-initdb.d/
# RUN /etc/init.d/postgresql start
# RUN /etc/init.d/postgresql status
#   psql --command " create user admin with superuser login passwrod 'admin';"
# RUN echo "postgresql-12のビルドを実行終了 ------------------------------->"


EXPOSE 5432
# # CMD [ "docker-entrypoint.sh" ]
# # ENTRYPOINT [ "tail", "-f", "/dev/null" ]
