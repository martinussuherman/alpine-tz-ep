# martinussuherman/alpine-tz-ep

[![](https://img.shields.io/badge/%20%20FROM%20%20-%20%20alpine%20%20-lightgray.svg)](https://hub.docker.com/_/alpine)  [![](https://images.microbadger.com/badges/image/martinussuherman/alpine-tz-ep.svg)](https://microbadger.com/images/martinussuherman/alpine-tz-ep "Get your own image badge on microbadger.com")  [![](https://images.microbadger.com/badges/commit/martinussuherman/alpine-tz-ep.svg)](https://microbadger.com/images/martinussuherman/alpine-tz-ep "Get your own commit badge on microbadger.com")  [![](https://images.microbadger.com/badges/license/martinussuherman/alpine-tz-ep.svg)](https://microbadger.com/images/martinussuherman/alpine-tz-ep "Get your own license badge on microbadger.com")  [![](https://images.microbadger.com/badges/version/martinussuherman/alpine-tz-ep.svg)](https://microbadger.com/images/martinussuherman/alpine-tz-ep "Get your own version badge on microbadger.com")

---

## What is this image for ?

This is an [Alpine Linux](https://hub.docker.com/_/alpine/) based image that bundles **tzdata**, **su-exec**, and some useful entrypoint scripts.

--- 

* [/create_user_group_home.sh](https://github.com/martinussuherman/alpine-tz-ep/blob/master/create_user_group_home.sh)

  Creates **user** with **userid**, **group**, **groupid** and **home** directory.
  The group and the home directory are assigned to the user, with ```/sbin/nologin``` as the default **shell**.
  
  User created from environment variable ```EUSER``` (default ```docker-user```), with uid from environment variable ```EUID``` (default ```1001```).
  
  Group created from environment variable ```EGROUP``` (default ```docker-group```), with gid from environment variable ```EGID``` (default ```1001```).
  
  Home directory created from environment variable ```EHOME``` (default ```/home/docker-user```).
  
---

* [/entrypoint_su-exec.sh](https://github.com/martinussuherman/alpine-tz-ep/blob/master/entrypoint_su-exec.sh) [command] [params...]  

  First creates user, group and home directory, by executing **```/create_user_group_home.sh```**.
  Then uses **```su-exec```** to exec ```$ENTRYPOINT_COMMAND``` with the given parameters as the user ```$EUSER```.
  > see [farmcoolcow/rclone](https://hub.docker.com/r/farmcoolcow/rclone) to see this entryoint in action.
  
---

* [/entrypoint_crond.sh](https://github.com/martinussuherman/alpine-tz-ep/blob/master/entrypoint_crond.sh) [params...]  

  First creates user, group and home directory, by executing **```/create_user_group_home.sh```**.   
  Then sets the crontab file ```$CROND_CRONTAB``` as the crontab of the user ```$EUSER```.   
  Finally executes **```crond```** with the given parameters.
  > see [farmcoolcow/rclone-cron](https://hub.docker.com/r/farmcoolcow/rclone-cron) to see this entryoint in action.
 
---

* [/entrypoint_exec.sh](https://github.com/martinussuherman/alpine-tz-ep/blob/master/entrypoint_exec.sh) [command] [params...]  

  First creates user, group and home directory, by executing **```/create_user_group_home.sh```**.
  Then uses **```exec```** to exec ```$ENTRYPOINT_COMMAND``` with the given parameters (as ```root```).
  
