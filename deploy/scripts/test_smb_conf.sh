#!/bin/sh
. "$(dirname "$0")/lib.sh"
log "Checking smb.conf with testparm"
docker exec -it ${TEST_CONTAINER} testparm -s /etc/samba/smb.conf || die "testparm failed"
