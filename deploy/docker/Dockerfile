FROM alpine:latest

RUN apk add --no-cache samba samba-common-tools bash shadow

# Create samba dirs and default permissions
RUN mkdir -p /srv/samba/public /srv/samba/private && \
    chmod 0777 /srv/samba/public && \
    addgroup -S samba && \
    mkdir -p /run/samba

COPY deploy/docker/entrypoint.sh /usr/local/bin/entrypoint.sh
COPY config/smb.conf /etc/samba/smb.conf

RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 445/tcp

VOLUME ["/srv/samba"]

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["smbd","-F","--no-process-group"]

