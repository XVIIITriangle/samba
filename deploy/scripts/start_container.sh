#!/bin/sh
. "$(dirname "$0")/lib.sh"
IMAGE_NAME="${IMAGE_NAME:-samba-alpine}"
TEST_NETWORK="${TEST_NETWORK:-samba-test-net}"
TEST_CONTAINER="${TEST_CONTAINER:-samba-alpine}"
# create network
docker network create "${TEST_NETWORK}" || true

# run container with test env and volumes (use tmp dir)
TMPDATA="$(mktemp -d)"
mkdir -p "${TMPDATA}/srv/samba/public" "${TMPDATA}/srv/samba/private/groupname" "${TMPDATA}/srv/samba/private/username"
chmod 0777 "${TMPDATA}/srv/samba/public"

log "Starting container ${TEST_CONTAINER}"
docker run --name "${TEST_CONTAINER}" --network "${TEST_NETWORK}" \
  -e SAMBA_USER="${SAMBA_USER:-username}" \
  -e SAMBA_PASSWORD="${SAMBA_PASSWORD:-Passw0rd}" \
  -e SAMBA_GROUP="${SAMBA_GROUP:-groupname}" \
  -e SAMBA_UID="${SAMBA_UID:-1254}" \
  -e SAMBA_GID="${SAMBA_GID:-2643}" \
  -v "${TMPDATA}/srv/samba":/srv/samba \
  -v "$(pwd)/../../config/smb.conf":/etc/samba/smb.conf:ro \
  "${IMAGE_NAME}" || die "failed to start container"
#sleep 2
