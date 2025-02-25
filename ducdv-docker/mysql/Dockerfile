FROM mysql:8.0

ENV MYSQL_DATABASE=ducdv_nro_db
ENV MYSQL_ROOT_PASSWORD=ducdv_nro_root
ENV MYSQL_USER=ducdv_nro_user
ENV MYSQL_PASSWORD=ducdv_nro_pass

# Copy file init_data.sql to Docker ENTRYPOINT
COPY init_data.sql /docker-entrypoint-initdb.d/
COPY my.cnf /etc/mysql/my.cnf

EXPOSE 3306
