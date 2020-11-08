# 在ubuntu下添加clash代理并将其设置为自动启动

## 将clash设置为service

service的启动脚本均放置在/etc/init.d目录下

1. 在该目录下建立名为clash的可执行文件：  
```sh
sudo touch /etc/init.d/clash
sudo chmod +x clash
```

2. 将下列代码添加到刚刚创建的clash文件中：  
```sh
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
```

通常service的脚本至少应该处理start，stop，status三个service control命令。最好也能够处理restart命令。  
这个脚本里使用了start-stop-daemon工具来在后台启动clash进程。具体参数可以参照`man start-stop-daemon`  
`status_of_proc`为一个函数，函数体在init-functions文件中。

## 设置clash service自动启动

使用命令`sudo update-rc.d clash defaults`将上一步设置的脚本添加进自动启动列表。  
update-rc.d命令自动根据clash查找/etc/init.d/clash文件，并自动根据注释中的`Default-Start`字段将此脚本添加到runlevel为3,4,5的子启动脚本中。
