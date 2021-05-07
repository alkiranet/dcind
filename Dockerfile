# Inspired by https://github.com/mumoshu/dcind
ARG BASE_IMAGE=alpine:3.13
FROM ${BASE_IMAGE}
LABEL maintainer="Dmitry Matrosov <amidos@amidos.me>"

ENV DOCKER_VERSION=20.10.3-r0 \
    DOCKER_COMPOSE_VERSION=1.25.4-r3

# Install Docker and Docker Compose
RUN apk --no-cache add \
    bash \
    docker>${DOCKER_VERSION} \
    docker-compose>${DOCKER_COMPOSE_VERSION} \
    && rm -rf /root/.cache

# Include functions to start/stop docker daemon
COPY docker-lib.sh /docker-lib.sh
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]
