#!/usr/bin/env bash
set -e

tag=2019-latest

images=$(docker images --all --quiet)
if [[ -n $images ]]; then
  docker rmi --force $images
fi

docker pull mcr.microsoft.com/mssql/server:2019-latest
docker build --no-cache -t nemesit/mssql-server-linux-tinytds .

docker run -p 1433:1433 -d nemesit/mssql-server-linux-tinytds
sleep 15
container=$(docker ps --all --quiet --filter ancestor=nemesit/mssql-server-linux-tinytds)

docker exec $container /opt/tinytds/setup.sh
docker commit $container nemesit/mssql-server-linux-tinytds
docker tag nemesit/mssql-server-linux-tinytds nemesit/mssql-server-linux-tinytds:$tag
docker push nemesit/mssql-server-linux-tinytds:$tag
docker push nemesit/mssql-server-linux-tinytds
docker stop $container
