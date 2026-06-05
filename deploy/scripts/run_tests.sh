#!/bin/sh
set -eu
DIR="$(cd "$(dirname "$0")" && pwd)"
. "${DIR}/lib.sh"

# load .env.test if present
if [ -f "${DIR}/.env.test" ]; then
  . "${DIR}/.env.test"
fi

sh "${DIR}/build_image.sh"
sh "${DIR}/start_container.sh"
sh "${DIR}/test_smb_conf.sh"
sh "${DIR}/test_shares.sh"
sh "${DIR}/stop_container.sh"

log "All tests completed successfully"

