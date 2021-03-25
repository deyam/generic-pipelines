#!/bin/bash
docker build -f Dockerfile.java -t deya/java-pipeline .
docker push deya/java-pipeline
