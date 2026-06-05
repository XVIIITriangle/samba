#!/bin/sh
. "$(dirname "$0")/lib.sh"
IMAGE_NAME="${IMAGE_NAME:-samba-alpine}"
BUILD_CONTEXT="${BUILD_CONTEXT:-../../}"   # adjust if needed
DOCKERFILE="${DOCKERFILE:-deploy/docker/Dockerfile}"

log "Building image ${IMAGE_NAME}"
docker build -t "${IMAGE_NAME}" -f "${BUILD_CONTEXT}${DOCKERFILE}" "${BUILD_CONTEXT}"

