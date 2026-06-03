#!/bin/bash
set -e

: "${SAMBA_USER:=username}"
: "${SAMBA_PASSWORD:=password}"
: "${SAMBA_GROUP:=groupname}"
: "${SAMBA_UID:=1000}"
: "${SAMBA_GID:=1000}"

if ! getent group "${SAMBA_GROUP}" >/dev/null 2>&1; then
  addgroup -g "${SAMBA_GID}" -S "${SAMBA_GROUP}" || addgroup -S "${SAMBA_GROUP}"
fi

if ! getent passwd "${SAMBA_USER}" >/dev/null 2>&1; then
  adduser -S -G "${SAMBA_GROUP}" -u "${SAMBA_UID}" -h "/home/${SAMBA_USER}" -s /bin/sh "${SAMBA_USER}" || \
    adduser -S -G "${SAMBA_GROUP}" "${SAMBA_USER}"
fi

mkdir -p /srv/samba/public
mkdir -p /srv/samba/private/"${SAMBA_GROUP}"
mkdir -p /srv/samba/private/"${SAMBA_USER}"

chown -R root:root /srv/samba
chmod 0777 /srv/samba/public

chown -R :${SAMBA_GROUP} /srv/samba/private/"${SAMBA_GROUP}"
chmod 2770 /srv/samba/private/"${SAMBA_GROUP}"

chown -R ${SAMBA_USER}:${SAMBA_GROUP} /srv/samba/private/"${SAMBA_USER}"
chmod 0700 /srv/samba/private/"${SAMBA_USER}"

(echo "${SAMBA_PASSWORD}"; echo "${SAMBA_PASSWORD}") | smbpasswd -s -a "${SAMBA_USER}" || true
smbpasswd -e "${SAMBA_USER}" || true

mkdir -p /run/samba
chown -R root:root /run/samba

exec "$@"

