FROM gradle:jdk8

RUN curl -fsSL get.docker.com | sh

RUN apt-get update && apt-get install -y jq zip

COPY stages /stages

#RUN docker buildx create --name simx-builder-multi
#RUN docker buildx use simx-builder-multi
#RUN docker buildx inspect --bootstrap

WORKDIR /app
