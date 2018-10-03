FROM alpine

ENV LABEL_MAINTAINER="Martinus Suherman" \
    LABEL_VENDOR="martinussuherman" \
    LABEL_IMAGE_NAME="martinussuherman/alpine-tz-ep" \
    LABEL_URL="https://hub.docker.com/r/martinussuherman/alpine-tz-ep/" \
    LABEL_VCS_URL="https://github.com/martinussuherman/alpine-tz-ep" \
    LABEL_DESCRIPTION="Alpine Linux based image that bundles tzdata, su-exec, and some useful entrypoint scripts." \
    LABEL_LICENSE="GPL-3.0" \
    # container/su-exec UID \
    EUID=1001 \
    # container/su-exec GID \
    EGID=1001 \
    # container/su-exec user name \
    EUSER=docker-user \
    # container/su-exec group name \
    EGROUP=docker-group \
    # container user home dir \
    EHOME= \
    # additional directories to create + chown (space separated) \
    ECHOWNDIRS= \
    # additional files to create + chown (space separated) \
    ECHOWNFILES= \
    # container timezone \
    TZ=UTC 

# Install shadow (for usermod and groupmod) and su-exec
RUN apk --no-cache --update add \
    shadow \
    su-exec \
    tzdata

COPY create_user_group_home.sh \
     chown_paths.sh \
     entrypoint_su-exec.sh \
     entrypoint_crond.sh \
     entrypoint_exec.sh \
     /

RUN chmod +x \
    /create_user_group_home.sh \
    /chown_paths.sh \
    /entrypoint_su-exec.sh \
    /entrypoint_crond.sh \
    /entrypoint_exec.sh

#
ARG LABEL_VERSION="latest"
ARG LABEL_BUILD_DATE
ARG LABEL_VCS_REF

# Build-time metadata as defined at http://label-schema.org
LABEL maintainer=$LABEL_MAINTAINER \
      org.label-schema.build-date=$LABEL_BUILD_DATE \
      org.label-schema.description=$LABEL_DESCRIPTION \
      org.label-schema.name=$LABEL_IMAGE_NAME \
      org.label-schema.schema-version="1.0" \
      org.label-schema.url=$LABEL_URL \
      org.label-schema.license=$LABEL_LICENSE \
      org.label-schema.vcs-ref=$LABEL_VCS_REF \
      org.label-schema.vcs-url=$LABEL_VCS_URL \
      org.label-schema.vendor=$LABEL_VENDOR \
      org.label-schema.version=$LABEL_VERSION
