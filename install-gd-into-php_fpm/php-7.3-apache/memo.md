```ini
docker container create --name <created container name>  \
# ホストとコンテナのボリュームをマウントする場合複数の組み合わせを指定できる
--mount type=bind,source='C:/Users/<user name>/source-dirctory/public',destination=/var/www/html \
--mount type=bind,source='C:/Users/<user name>/source-dirctory/',destination=/var/www/ \
-p 8080:80 \
<container image name>

```
