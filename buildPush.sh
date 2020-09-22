#!/usr/bin/env bash
IMAGE_NAME="haakco/postgres13"
docker build --rm -t "${IMAGE_NAME}" .
docker push "${IMAGE_NAME}"
