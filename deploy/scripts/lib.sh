#!/bin/sh
set -eu

SAMBA_PASSWORD="${SAMBA_PASSWORD:-Passw0rd}"
SAMBA_USER="${SAMBA_USER:-username}"
SAMBA_GROUP="${SAMBA_GROUP:-groupname}"
SAMBA_GID="${SAMBA_GID:-2398}"
SAMBA_UID="${SAMBA_UID:-1435}"

TEST_NETWORK="${TEST_NETWORK:-samba-test-net}"
IMAGE_NAME="${IMAGE_NAME:-samba-alpine}"
TEST_CONTAINER="${TEST_CONTAINER:-samba-alpine}"

die() { echo "ERROR: $*" >&2; exit 1; }
log() { echo "[`date -Is`] $*"; }
