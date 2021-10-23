记录一些linux下通用的工具，技巧

[[_TOC_]]

# 系统配置

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

# [Bash](bash/index)


# 常用命令

## sed
sed用来进行文字处理

`sed [OPTION]... {script-only-if-no-other-script} [input-file]...`

其中：
- -e 后的命令行作为命令脚本;
- 或者，-f 后指定的文件内容为命令脚本;
- 或者，如果没有-e和-f，则第一个非参数命令行作为脚本，其余的非参数命令行为输入文件。
- -i 直接修改源文件

sed可以：
- 替换文件中文本（`[range]s/<regex>/<replacement>/<parameter>` s命令）
- 删除行（d命令）
- append或insert文本（a或i命令）

sed中的正则表达式：
- sed的正则为POSIX正则，不支持\d, \s等。需要使用[[:digit:]]代替
- 如果不使用-E (extended)参数，'['需要被转义才能得到字面上的'['字符，否则为特殊字符; 其他的特殊字符不转义则是字面字符; 如果需要其特殊意义则需要转义。
- 使用-E, 特殊字符如'[]', '()', '{}', '+'均代表其特殊意义；如果需要使用字面字符，则需要转义。
- 建议：尽量使用-E, 可以获得更好的可读性。


# VIM

# X桌面
