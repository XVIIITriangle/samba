#!/bin/sh
. "$(dirname "$0")/lib.sh"
TEST_CONTAINER="${TEST_CONTAINER:-samba-alpine}"
log "Stopping container ${TEST_CONTAINER}"
docker rm -f "${TEST_CONTAINER}" || true
docker network rm "${TEST_NETWORK:-samba-test-net}" || true

