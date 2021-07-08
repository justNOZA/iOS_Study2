FROM postgres:13.3

ENV POSTGRES_USER user
ENV POSTGRES_PASSWORD password
ENV POSTGRES_DB test 

COPY ./script/ /docker-entrypoint-initdb.d/