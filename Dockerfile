    FROM ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm

RUN apt-get update && \
    apt-get install -Vy \
    -o APT::Install-Recommends=false -o APT::Install-Suggests=false \
    ca-certificates \
    gnupg curl

# RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4 && \
#    echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/4.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.0.list && \

RUN curl -fsSL https://pgp.mongodb.com/server-4.4.asc | gpg -o /usr/share/keyrings/mongodb-server-4.4.gpg --dearmor && \
    echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-4.4.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/4.4 multiverse" | \
    tee /etc/apt/sources.list.d/mongodb-org-4.4.list


RUN apt-get update && \
    apt-get install -Vy \
    mongodb-database-tools && \
    rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*
