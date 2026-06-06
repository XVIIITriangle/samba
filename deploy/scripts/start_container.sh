#!/bin/sh
. "$(dirname "$0")/lib.sh"
docker network create "${TEST_NETWORK}" || true

TMPDATA="$(mktemp -d)"
mkdir -p "${TMPDATA}/srv/samba/public" "${TMPDATA}/srv/samba/private/groupname" "${TMPDATA}/srv/samba/private/username"
chmod 0777 "${TMPDATA}/srv/samba/public"

echo "${SAMBA_GID}"
log "Starting container ${TEST_CONTAINER}"
docker run --name "${TEST_CONTAINER}" --network "${TEST_NETWORK}" \
  -e "SAMBA_USER=${SAMBA_USER}" \
  -e "SAMBA_PASSWORD=${SAMBA_PASSWORD}" \
  -e "SAMBA_GROUP=${SAMBA_GROUP}" \
  -e "SAMBA_UID=${SAMBA_UID}" \
  -e "SAMBA_GID=${SAMBA_GID}" \
  -v "${TMPDATA}/srv/samba":/srv/samba \
  -v "$(pwd)/../../config/smb.conf":/etc/samba/smb.conf:ro \
  "${IMAGE_NAME}" || die "failed to start container"
#sleep 2
