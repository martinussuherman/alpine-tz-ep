#!/bin/sh
# The goal of this script is to allow mapping of host user (the one running
# docker), to the desired container user, as to enable the use of more
# restrictive file permission (700 or 600)

# does a group with name = EGROUP already exist ?
EXISTING_GID=$( getent group $EGROUP | cut -f3 -d ':' )

if [ ! -z $EXISTING_GID ]; then
   if [ $EXISTING_GID != $EGID ]; then
      # change id of the existing group
      groupmod -g $EGID $EGROUP
   fi
else
   # create new group with id = EGID
   addgroup -g $EGID $EGROUP
fi

# does a user with name = EUSER already exist ?
EXISTING_UID=$( getent passwd $EUSER | cut -f3 -d ':' )

if [ ! -z $EXISTING_UID ]; then
   if [ $EXISTING_UID != $EUID ]; then
      # change login, home, shell (nologin) and primary group of the existing user
      usermod -u $EUID -d $EHOME -s /sbin/nologin -g $EGROUP $EUSER
   fi
else
   # create new user with id = EUID, group = EGROUP and home directory = EHOME,
   # with nologin shell
   adduser -s /sbin/nologin -u $EUID -G $EGROUP -h $EHOME -D $EUSER
fi

# change ownership of home directory
chown $EUSER:$EGROUP $EHOME
