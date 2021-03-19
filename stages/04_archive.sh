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
docker run --rm --privileged docker/binfmt:a7996909642ee92942dcd6cff44b9b95f08dad6 --install linux/arm64,linux/amd64
docker buildx create --name simx-builder-multi
docker buildx use simx-builder-multi
docker buildx inspect --bootstrap
docker buildx build --platform linux/arm64,linux/amd64 -t "${image}" .
docker logout
docker login \
    -u "${DOCKER_USERNAME?:}" \
    -p "${DOCKER_PASSWORD?:}" \
    "${registry}"
docker push "${image}"
