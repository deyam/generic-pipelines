#!/usr/bin/env bash

echo
echo "Archiving Application"

registry=$(jq -r .archive.registry pipeline.json)
repository=$(jq -r .archive.repository pipeline.json)
image="${registry}/${repository}:latest"

docker login \
    -u "${DOCKER_USERNAME?:}" \
    -p "${DOCKER_PASSWORD?:}" \
    "${registry}"
docker run --rm --privileged docker/binfmt:latest --install linux/arm64,linux/amd64
RUN docker buildx create --name simx-builder-multi
RUN docker buildx use simx-builder-multi
RUN docker buildx inspect --bootstrap
docker buildx build --platform linux/arm64,linux/amd64 -t "${image}" .
docker logout
docker login \
    -u "${DOCKER_USERNAME?:}" \
    -p "${DOCKER_PASSWORD?:}" \
    "${registry}"
docker push "${image}"
