代理
=======


clash的安装与配置
-------

### 安装clash
到 https://github.com/Dreamacro/clash/releases 下载linux-amd的安装包。  
解压里面的文件到~/bin文件夹。  
给文件添加执行权限。  
直接运行文件即可启动clash


### 配置clash
clash需要两个配置文件：~/.config/clash/config.yaml和~/.config/clash/Country.mmdb  
其中Country.mmdb需要从Clash for Windows中复制（TODO: 寻找可用下载地址）  
config.yaml文件则从nplus.icu网站获取URL进行下载  

打开下载的config.yaml文件，找到“external-controller: '0.0.0.0:9090'”一行。将IP修改为127.0.0.1

访问 http://clash.razord.top/ 这是clash的网页端配置接口。输入刚才设置的IP和端口号，进入配置页面。  
如果配置正确，应该能够看到代理列表。  
点击右侧“Speed Test”，进行速度测试，然后在第一列选择合适的代理。

至此梯子已经搭好，配置Chrome插件或系统代理来使用梯子。


### Clash的配置文件
为了方便的更新代理服务器列表，可以使用clash的proxy-providers功能：使用一个主配置文件[config.yaml](./config.yaml)，其中引用nplus提供的代理服务器地址[nplus.yaml](./nplus.yaml)  
```
proxy-providers:
  nplus:
    type: file
    path: ./nplus.yaml
    health-check:
      enable: true
      interval: 108000
      url: http://www.gstatic.com/generate_204
```

然后在接下来的proxy-groups，引用这个proxy-providers  
```
proxy-groups:
  - name: LOADBALANCE
    type: load-balance
    use:
      - nplus
    url: http://www.gstatic.com/generate_204
    interval: 300
```


### 自动更新配置及IP数据库
TODO


### 将clash设置为自动启动
service的启动脚本均放置在/etc/init.d目录下

1. 在该目录下建立名为clash的可执行文件：  
```sh
sudo touch /etc/init.d/clash
sudo chmod +x clash
```

1. 将下列代码添加到刚刚创建的clash文件中：  
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

#### 设置clash service自动启动
使用命令`sudo update-rc.d clash defaults`将上一步设置的脚本添加进自动启动列表。  
update-rc.d命令自动根据clash查找/etc/init.d/clash文件，并自动根据注释中的`Default-Start`字段将此脚本添加到runlevel为3,4,5的子启动脚本中。



### 其他方法 

Clash is meant to be run in the background, there's currently no way to implement daemons elegantly with Golang. We can daemonize Clash with third-party tools.
Clash通常应该作为一个服务运行在后台。但是目前golang语言没有很好的方法支持程序作为服务运行。我们可以使用第三方工具来让clash作为服务运行。

#### systemd
Copy Clash binary to `/usr/local/bin` and configuration files to `/etc/clash`:
```
$ cp clash /usr/local/bin
$ cp config.yaml /etc/clash/
$ cp Country.mmdb /etc/clash/
```

Create the systemd configuration file at `/etc/systemd/system/clash.service`:
```ini
[Unit]
Description=Clash daemon, A rule-based proxy in Go.
After=network.target

[Service]
Type=simple
Restart=always
ExecStart=/usr/local/bin/clash -d /etc/clash

[Install]
WantedBy=multi-user.target
```

Launch clashd on system startup with:
```
$ systemctl enable clash
```

Launch clashd immediately with:
```
$ systemctl start clash
```

Check the health and logs of Clash with:
```
$ systemctl status clash
$ journalctl -xe
```

Credits to [ktechmidas](https://github.com/ktechmidas) for this guide. ([#754](https://github.com/Dreamacro/clash/issues/754))

#### Docker
We recommend deploying Clash with [Docker Compose](https://docs.docker.com/compose/) if you're on Linux. On macOS, it's recommended to use the third-party Clash GUI [ClashX Pro](https://install.appcenter.ms/users/clashx/apps/clashx-pro/distribution_groups/public). ([#770](https://github.com/Dreamacro/clash/issues/770#issuecomment-650951876))

```yaml
version: '3'
services:
  clash:
    # ghcr.io/dreamacro/clash
    # ghcr.io/dreamacro/clash-premium
    # dreamacro/clash
    # dreamacro/clash-premium
    image: dreamacro/clash
    container_name: clash
    volumes:
      - ./config.yaml:/root/.config/clash/config.yaml
      # - ./ui:/ui # dashboard volume
    ports:
      - "7890:7890"
      - "7891:7891"
      # - "8080:8080" # external controller (Restful API)
    restart: unless-stopped
    network_mode: "bridge" # or "host" on Linux
```

Save as `docker-compose.yaml`, create `config.yaml` in the same directory, and run the below commands to get Clash up:

```
$ docker-compose up -d
```
 
You can view the logs with:

```
$ docker-compose logs
```

Stop Clash with:

```
$ docker-compose stop
```




v2ray
-------
TODO
