# Stage 1: Build environment
FROM bitnami/minideb:bullseye AS builder

ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm

RUN apt-get update && \
    apt-get install -Vy \
    -o APT::Install-Recommends=false -o APT::Install-Suggests=false \
    ca-certificates \
    gnupg curl

RUN curl -fsSL https://pgp.mongodb.com/server-4.4.asc | gpg -o /usr/share/keyrings/mongodb-server-4.4.gpg --dearmor && \
    echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-4.4.gpg] http://repo.mongodb.org/apt/debian bullseye/mongodb-org/4.4 main" \ 
    | tee /etc/apt/sources.list.d/mongodb-org-4.4.list

RUN apt-get update && \
    apt-get install -Vy \
    mongodb-database-tools && \
    apt-get remove -Vy --purge gnupg curl

# Stage 2: Final image
FROM bitnami/minideb:bullseye

COPY --from=builder /usr/bin/mongodump /usr/bin/mongodump
COPY --from=builder /usr/bin/mongorestore /usr/bin/mongorestore

CMD ["mongodump"]

