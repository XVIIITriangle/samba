#!/bin/sh
set -eu

die() { echo "ERROR: $*" >&2; exit 1; }
log() { echo "[`date -Is`] $*"; }
