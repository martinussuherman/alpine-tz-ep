# martinussuherman/alpine-tz-ep

[![](https://img.shields.io/badge/%20%20FROM%20%20-%20%20alpine%20%20-lightgray.svg)](https://hub.docker.com/_/alpine)  [![](https://images.microbadger.com/badges/image/martinussuherman/alpine-tz-ep.svg)](https://microbadger.com/images/martinussuherman/alpine-tz-ep "Get your own image badge on microbadger.com")  [![](https://images.microbadger.com/badges/commit/martinussuherman/alpine-tz-ep.svg)](https://microbadger.com/images/martinussuherman/alpine-tz-ep "Get your own commit badge on microbadger.com")  [![](https://images.microbadger.com/badges/license/martinussuherman/alpine-tz-ep.svg)](https://microbadger.com/images/martinussuherman/alpine-tz-ep "Get your own license badge on microbadger.com")  [![](https://images.microbadger.com/badges/version/martinussuherman/alpine-tz-ep.svg)](https://microbadger.com/images/martinussuherman/alpine-tz-ep "Get your own version badge on microbadger.com")

---

## What is this image for ?

This is a [Minimal Alpine Linux image with glibc](https://hub.docker.com/r/jeanblanchard/alpine-glibc) based image that bundles **tzdata**, **su-exec**, and some useful entrypoint scripts.

--- 

* [create_user_group_home](https://github.com/martinussuherman/alpine-tz-ep/blob/dev-glibc/create_user_group_home)

  Creates **user** with **userid**, **group**, **groupid** and **home** directory.
  The group and the home directory are assigned to the user, with **shell** set based on values of environment variable ```ENOLOGIN``` (see below for more info).
  
  User created from environment variable ```EUSER``` (default ```docker-user```), with uid from environment variable ```EUID``` (default ```1001```).

  Group created from environment variable ```EGROUP``` (default ```docker-group```), with gid from environment variable ```EGID``` (default ```1001```).
  
  Home directory created from environment variable ```EHOME``` (default ```/home/docker-user```).

  If variable ```ENOLOGIN``` equals yes then use ```/sbin/nologin``` as **shell**, else use **default shell** (```/bin/sh```).

  If variable ```ECHOWNHOME``` equals yes then the home directory will be chown'ed to ```EUSER```:```EGROUP```

---

* [chown_paths](https://github.com/martinussuherman/alpine-tz-ep/blob/dev-glibc/chown_paths)

  Chown directories in ```ECHOWNDIRS```, create them if not exist.
  Chown files in ```ECHOWNFILES```, create them if not exist.

---

* [entrypoint_su-exec](https://github.com/martinussuherman/alpine-tz-ep/blob/dev-glibc/entrypoint_su-exec) [command] [params...]  

  First creates user, group and home directory, by executing **```create_user_group_home```**.
  Then uses **```su-exec```** to exec ```$ENTRYPOINT_COMMAND``` with the given parameters as the user ```$EUSER```.
  > see [martinussuherman/alpine-tz-ep-code-server](https://hub.docker.com/r/martinussuherman/alpine-tz-ep-code-server) to see this entryoint in action.
  
---

* [entrypoint_crond](https://github.com/martinussuherman/alpine-tz-ep/blob/dev-glibc/entrypoint_crond) [params...]  

  First creates user, group and home directory, by executing **```create_user_group_home```**.   
  Then sets the crontab file ```$CROND_CRONTAB``` as the crontab of the user ```$EUSER```.   
  Finally executes **```crond```** with the given parameters.
  > see [farmcoolcow/rclone-cron](https://hub.docker.com/r/farmcoolcow/rclone-cron) to see this entryoint in action.
 
---

* [entrypoint_exec](https://github.com/martinussuherman/alpine-tz-ep/blob/dev-glibc/entrypoint_exec) [command] [params...]  

  First creates user, group and home directory, by executing **```create_user_group_home```**.
  Then uses **```exec```** to exec ```$ENTRYPOINT_COMMAND``` with the given parameters (as ```root```).
  
