FROM google/cloud-sdk:alpine

RUN apk add bash findutils rsync

ENTRYPOINT ["bash", "-c", "/backup/gcs-upload.sh;"]