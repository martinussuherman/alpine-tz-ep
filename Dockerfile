FROM jeanblanchard/alpine-glibc:3.12

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

COPY create_user_group_home \
     chown_paths \
     entrypoint_su-exec \
     entrypoint_crond \
     entrypoint_exec \
     /usr/bin/

RUN chmod +x \
    /usr/bin/create_user_group_home \
    /usr/bin/chown_paths \
    /usr/bin/entrypoint_su-exec \
    /usr/bin/entrypoint_crond \
    /usr/bin/entrypoint_exec
