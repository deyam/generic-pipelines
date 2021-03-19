#!/usr/bin/env bash

echo
echo "Building Application"

application_type=$(jq -r .application.type pipeline.json)

case "${application_type}" in
  "java")
    echo "Building with gradle/wrapper"
    #mvn clean package
    gradle wrapper
    ./gradlew build
    ;;
  "netcore")
    dotnet restore
    dotnet build -c Release
    ;;
  "node")
    npm install
    ;;
  *)
    echo "Unable to build application type ${application_type}"
    exit 1
    ;;
esac
