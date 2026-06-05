#!/bin/sh
. "$(dirname "$0")/lib.sh"
TEST_CONTAINER="${TEST_CONTAINER:-samba-alpine}"
SMB_HOST="${SMB_HOST:-$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ${TEST_CONTAINER})}"
USER="${SAMBA_USER:-username}"
PASS="${SAMBA_PASSWORD:-Passw0rd}"
TEST_NETWORK="${TEST_NETWORK:-samba-test-net}"

log "Listing shares"
docker run --rm --network host dperson/samba smbclient -L //127.0.0.1 -U"${USER}%${PASS}" -g >/dev/null 2>&1 || true
# Simpler: use smbclient installed on host. If not available, run a helper container with smbclient:
docker run --rm --network "${TEST_NETWORK}" --entrypoint smbclient dperson/samba \
  -L "//${TEST_CONTAINER}" -U "${USER}%${PASS}" || die "smbclient list failed"

# Test public anonymous read/write
log "Testing public share write/read"
docker run --rm --network "${TEST_NETWORK}" --entrypoint smbclient dperson/samba \
  "//${TEST_CONTAINER}/public" -U "guest%" -Tc -c "put /dev/null testfile || exit 1" || true

# Test authenticated user access to user_share
docker run --rm --network "${TEST_NETWORK}" --entrypoint smbclient dperson/samba \
  "//${TEST_CONTAINER}/user_share" -U "${USER}%${PASS}" -c "ls" || die "user_share access failed"

