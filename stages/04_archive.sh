#!/usr/bin/env bash

echo
echo "Archiving Application"

registry=$(jq -r .archive.registry pipeline.json)
repository=$(jq -r .archive.repository pipeline.json)
version=$(jq -r .archive.version pipeline.json)
image="${registry}/${repository}:${version}"

docker login \
    -u "${DOCKER_USERNAME?:}" \
    -p "${DOCKER_PASSWORD?:}" \
    "${registry}"
#docker buildx build --platform linux/arm64,linux/amd64 -t "${image}" .
docker build -t "${image}" .
docker logout
docker login \
    -u "${DOCKER_USERNAME?:}" \
    -p "${DOCKER_PASSWORD?:}" \
    "${registry}"
docker push "${image}:${version}"
