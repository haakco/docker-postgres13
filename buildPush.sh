#!/usr/bin/env bash
export POSTGRES_VERSION=${POSTGRES_VERSION:-'13'}
export IMAGE_NAME=${IMAGE_NAME:-"haakco/postgres${POSTGRES_VERSION}"}
./build.sh
docker push "${IMAGE_NAME}"
