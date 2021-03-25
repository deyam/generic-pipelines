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
<<<<<<< HEAD
=======
##docker run -d --name nginx nginx
##docker run --rm --privileged docker/binfmt:820fdd95a9972a5308930a2bdfb8573dd4447ad3 
#docker run --rm --privileged docker/binfmt:a7996909642ee92942dcd6cff44b9b95f08dad6 --install linux/arm64,linux/amd64
#docker buildx create --name simx-builder-multi
#docker buildx use simx-builder-multi
#docker buildx inspect --bootstrap
>>>>>>> 3bff29055116b586e6ea11b5faefb41ec9301b01
#docker buildx build --platform linux/arm64,linux/amd64 -t "${image}" .
docker build -t "${image}" .
docker logout
docker login \
    -u "${DOCKER_USERNAME?:}" \
    -p "${DOCKER_PASSWORD?:}" \
    "${registry}"
docker push "${image}:${version}"
