#!/usr/bin/env bash
set -e

tag=2019-latest

images=$(docker images --all --quiet)
if [[ -n $images ]]; then
  docker rmi --force $images
fi

docker pull mcr.microsoft.com/mssql/server:2019-latest
docker build --no-cache -t nemesit/mssql-server-linux-rails .

docker run -p 1433:1433 -d nemesit/mssql-server-linux-rails
sleep 15
container=$(docker ps --all --quiet --filter ancestor=nemesit/mssql-server-linux-rails)

docker exec $container /opt/rails/setup.sh
docker commit $container nemesit/mssql-server-linux-rails
docker tag nemesit/mssql-server-linux-rails nemesit/mssql-server-linux-rails:$tag
docker push nemesit/mssql-server-linux-rails:$tag
docker push nemesit/mssql-server-linux-rails
docker stop $container
