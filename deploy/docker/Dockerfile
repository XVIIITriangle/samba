FROM alpine:latest
LABEL MAINTAINER="XVIIITriangle <petrikeev.boss@mail.ru>"

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
#COPY ../../config/smb.conf /etc/samba/smb.conf

RUN apk --no-cache update && apk --no-cache upgrade && apk --no-cache add samba-common-tools samba-client samba-server && chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 445/tcp

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD []
