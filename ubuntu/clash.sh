#!/bin/sh

### BEGIN INIT INFO
# Provides:          clash
# Required-Start:    $local_fs
# Required-Stop:     $local_fs
# Default-Start:     3 4 5
# Default-Stop:      1
# Short-Description: start proxy
# Description: Start clash proxy
### END INIT INFO

. /lib/lsb/init-functions

case "$1" in
  start)
    start-stop-daemon --start -b --pidfile /run/clash.pid --exec /home/imafish/bin/clash-linux-amd64 -- -d /home/imafish/.config/clash
    ;;

  stop)
    start-stop-daemon --stop --retry 5 --pidfile /run/clash.pid
    ;;

  status)
    status_of_proc -p /run/sshd.pid /usr/sbin/sshd sshd && exit 0 || exit $?
    ;;

  *)
    log_action_msg "Usage: /etc/init.d/ssh {start|stop|reload|force-reload|restart|try-restart|status}" || true
    exit 1
esac

exit 0
