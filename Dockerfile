# Use the official Alpine Linux base image
FROM alpine:3.17

# Update package repositories and install MongoDB tools package (4.x version)
RUN apk upgrade --update-cache --available && \
    apk add --update --no-cache mongodb-tools=~4 
