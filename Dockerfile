FROM alpine:3.10

LABEL version="1.0.0"
LABEL maintainer="OCAD University <platform-coop-development-kit@lists.inclusivedesign.ca>" \
      org.label-schema.vendor="OCAD University" \
      com.github.actions.name="Rsync Deploy" \
      com.github.actions.description="Deploy content to a remote server using rsync." \
      com.github.actions.icon="refresh-cw" \
      com.github.actions.color="green"

RUN apk add --no-cache --virtual .run-deps rsync=3.1.3-r1 openssh=8.1_p1-r0 && \
    rm -rf /var/cache/apk/*

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
