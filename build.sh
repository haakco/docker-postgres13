#!/usr/bin/env bash
export PROXY=${PROXY:-''}
export POSTGRES_VERSION=${POSTGRES_VERSION:-'13'}
export IMAGE_NAME=${IMAGE_NAME:-"haakco/postgres${POSTGRES_VERSION}"}
docker build \
  --build-arg POSTGRES_VERSION="${POSTGRES_VERSION}" \
  --build-arg PROXY="${PROXY}" \
  --rm -t ${IMAGE_NAME} .
