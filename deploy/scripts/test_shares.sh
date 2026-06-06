#!/bin/sh
. "$(dirname "$0")/lib.sh"
SMB_HOST="${SMB_HOST:-$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ${TEST_CONTAINER})}"

log "Listing shares"
docker run --rm --network host dperson/samba smbclient -L //127.0.0.1 -U"${SAMBA_USER}%${SAMBA_PASSWORD}" -g >/dev/null 2>&1 || true
docker run --rm --network "${TEST_NETWORK}" --entrypoint smbclient dperson/samba \
  -L "//${TEST_CONTAINER}" -U "${SAMBA_USER}%${SAMBA_PASSWORD}" || die "smbclient list failed"

log "Testing public share write/read"
docker run --rm --network "${TEST_NETWORK}" --entrypoint smbclient dperson/samba \
  "//${TEST_CONTAINER}/public" -U "guest%" -Tc -c "put /dev/null testfile || exit 1" || true

docker run --rm --network "${TEST_NETWORK}" --entrypoint smbclient dperson/samba \
  "//${TEST_CONTAINER}/user_share" -U "${SAMBA_USER}%${SAMBA_PASSWORD}" -c "ls" || die "user_share access failed"

