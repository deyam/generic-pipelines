FROM gradle:jdk8

RUN curl -fsSL get.docker.com | sh

RUN apt-get update && apt-get install -y jq zip

COPY stages /stages
<<<<<<< HEAD

#RUN docker buildx create --name simx-builder-multi
#RUN docker buildx use simx-builder-multi
#RUN docker buildx inspect --bootstrap
=======
#docker run --rm --privileged docker/binfmt:a7996909642ee92942dcd6cff44b9b95f08dad6
RUN docker buildx create --name simx-builder-multi
RUN docker buildx use simx-builder-multi
RUN docker buildx inspect --bootstrap
>>>>>>> 3bff29055116b586e6ea11b5faefb41ec9301b01

WORKDIR /app
