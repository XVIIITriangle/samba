#!/bin/sh
. "$(dirname "$0")/lib.sh"
TEST_CONTAINER="${TEST_CONTAINER:-samba-alpine}"
log "Checking smb.conf with testparm"
docker exec -it "${TEST_CONTAINER}" testparm -s /etc/samba/smb.conf #|| die "testparm failed"
rc=$?
docker ps -a --filter name="${TEST_CONTAINER}" --format '{{.Names}} {{.Status}}'
docker logs --tail 50 "${TEST_CONTAINER}"
exit $rc
