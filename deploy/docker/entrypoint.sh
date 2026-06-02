#!/bin/sh
# samba configuration template

set -eu

SMBGROUP=smbgroup

if [ ! -f /etc/samba/smb.conf ]; then
	echo "[ EE ] /etc/samba/smb.conf not found"
	exit 1
fi

if [ grep -q smbgroup /etc/groups ]; then
	# todo!
fi	
