#!/bin/sh

# does a group with id = EGID already exist ?
EXISTING_GROUP=$(getent group $EGID | cut -f1 -d ':')

if [ ! -z $EXISTING_GROUP ]; then
  # change name of the existing group
  groupmod -n $EGROUP $EXISTING_GROUP
else
  # create new group with id = EGID
  addgroup -g $EGID $EGROUP
fi

# does a user with id = EUID already exist ?
EXISTING_USER=$(getent passwd $EUID | cut -f1 -d ':')

if [ ! -z $EXISTING__USER ]; then
  # change login, home, shell (nologin) and primary group of the existing user
  usermod -l $EUSER -d $EHOME -s /sbin/nologin -g $EGID $EXISTING_USER
else
  # create new user with id = EUID, group = EGROUP and home directory = EHOME, with nologin shell
  adduser -s /sbin/nologin -u $EUID -G $EGROUP -h $EHOME -D $EUSER
fi  

# create user, group, and home
chown $EUSER:$EGROUP $EHOME
