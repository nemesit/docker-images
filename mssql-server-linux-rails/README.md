
## mssql-server-linux-rails

Using the official image for Microsoft SQL Server for Linux.

* https://hub.docker.com/r/microsoft/mssql-server-linux/
* https://github.com/rails-sqlserver/docker-images
* https://github.com/rails-sqlserver/activerecord-sqlserver-adapter

Includes test database & users w/permissions needed to test the SQL Server adapter for Rails.

All commands assume that the `$PWD` is this directory.


### Build

Fully automated build

```shell
./build.sh
```


### Build Testing

Simple build command.

```shell
docker build -t nemesit/mssql-server-linux-rails .
```

Ensure that the build script worked.

```shell
docker run -p 1433:1433 -d nemesit/mssql-server-linux-rails
container=$(docker ps --all --quiet --filter ancestor=nemesit/mssql-server-linux-rails)
docker exec -it $container bash

/opt/mssql-tools/bin/sqlcmd -U sa -P super01S3cUr3 -S localhost -Q "SELECT name FROM master.dbo.sysdatabases"
/opt/mssql-tools/bin/sqlcmd -U sa -P super01S3cUr3 -S localhost -Q "SELECT loginname, dbname FROM syslogins"

# if needed
# yarn install sql-cli

mssql -u rails -p '' -s  localhost -o 1433 -d activerecord_unittest
.quit

docker stop $container
```
