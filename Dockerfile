FROM alpine:3.12

ENV \
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
    # should user home dir get chown'ed? (yes/no) \
    ECHOWNHOME=no \
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
ARG LABEL_MAINTAINER
ARG LABEL_BUILD_DATE
ARG LABEL_DESCRIPTION
ARG LABEL_LICENSE
ARG LABEL_NAME
ARG LABEL_URL
ARG LABEL_VCS_REF
ARG LABEL_VCS_URL
ARG LABEL_VENDOR
ARG LABEL_VERSION

# Build-time metadata as defined at http://label-schema.org
LABEL maintainer=$LABEL_MAINTAINER \
      org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$LABEL_BUILD_DATE \
      org.label-schema.description=$LABEL_DESCRIPTION \
      org.label-schema.license=$LABEL_LICENSE \
      org.label-schema.name=$LABEL_NAME \
      org.label-schema.url=$LABEL_URL \
      org.label-schema.vcs-ref=$LABEL_VCS_REF \
      org.label-schema.vcs-url=$LABEL_VCS_URL \
      org.label-schema.vendor=$LABEL_VENDOR \
      org.label-schema.version=$LABEL_VERSION
