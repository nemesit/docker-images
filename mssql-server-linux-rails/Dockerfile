FROM mcr.microsoft.com/mssql/server:2019-latest
MAINTAINER Felix Gebhard <nemesit@myriadvisuals.com>
LABEL description="Microsoft SQL Server for Linux - Rails Testing" \
      version="2019-latest"

ENV ACCEPT_EULA Y
ENV SA_PASSWORD super01S3cUr3
EXPOSE 1433

COPY rails/* /opt/rails/
