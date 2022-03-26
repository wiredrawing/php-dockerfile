#!/bin/bash


# 起動時にDBユーザをいくつか作っておきたい

# admin
psql -U postgres -c "create role admin with superuser login password 'admin';";
# subuser
psql -U postgres -c "create role subuser with superuser login password 'subuser';";
# alter コマンドも実行できる
psql -U postgres -c "alter role admin with password 'admin2';";

