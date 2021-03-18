FROM gradle:jdk15

RUN curl -fsSL get.docker.com | sh

RUN apt-get update && apt-get install -y jq zip

COPY stages stages

WORKDIR /app
