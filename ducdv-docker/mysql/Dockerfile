FROM mysql:8.0

ENV MYSQL_DATABASE=ducdv_nro_db
ENV MYSQL_ROOT_PASSWORD=ducdv_nro_root
ENV MYSQL_USER=ducdv_nro_user
ENV MYSQL_PASSWORD=ducdv_nro_pass

# Copy file init_data.sql to Docker ENTRYPOINT
COPY ducdv-docker/mysql/init_data.sql /docker-entrypoint-initdb.d/
COPY ducdv-docker/mysql/my.cnf /etc/mysql/my.cnf

EXPOSE ${DB_PORT}
