记录一些linux下通用的工具，技巧

[[_TOC_]]

# 系统配置、工具

## 自启动

1. 开机启动时自动运行程序  
Linux加载后, 它将初始化硬件和设备驱动, 然后运行第一个进程init。init根据配置文件继续引导过程，启动其它进程。通常情况下，修改放置在  
/etc/rc或  
/etc/rc.d 或  
/etc/rc?.d  
目录下的脚本文件，可以使init自动启动其它程序。  
/etc/rc.d/rc.local 文件(该文件通常是系统最后启动的脚本)

2. rcS.d  
（此处需要进一步确认）  
rcS.d 中的‘S’为“Startup”，所有runlevel均需要的脚本可以放置在这里。

3. 登录时自动运行程序  
用户登录时，bash先自动执行系统管理员建立的全局登录script  
/ect/profile  
然后bash在用户起始目录下按顺序查找三个特殊文件中的一个：  
/.bash_profile  
/.bash_login  
/.profile  
但只执行最先找到的一个。

4. 创建一个Service并配置自启动：  
通常不同distribution会有不同的工具来配置service。  
[这里](../ubuntu/clash.md)是一个在ubuntu下配置clash代理自动启动的步骤。

# 常用命令

# VIM

# X桌面
