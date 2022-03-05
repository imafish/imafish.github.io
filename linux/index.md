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

# grub
- Ubuntu用grub2代替了传统grub。grub2提供了很多额外的功能，但本质上和grub是同一个原理。  
- grub2生成一个boot.img(512Byte)写入MBR的第一个扇区，用来引导系统启动；一般boot.img会读取core.img并将控制权转移给core.img。core.img负责进行下一步引导。  
- grub2命令行常用命令：
  - ls
    - 不加参数则列出grub可见的所有设备。加入参数则列出文件列表。
  - lsmod和insmod
    - 分别用于列出已加载的模块和调用指定的模块。
    - 若要导入支持ext文件系统的模块时，只需导入ext2.mod即可，实际上也没有ext3和ext4对应的模块。
    - 若要引导Windows，需要导入ntfs模块：`insmod ntfs`
  - linux和linux16
    - 加载linux内核。必须进跟着使用initrd或initrd16命令加载ramdisk文件。
    - 必须给内核传入root启动参数。如：`linux16 /vmlinuz-3.10.0-327.el7.x86_64 root=UUID=edb1bf15-9590-4195-aa11-6dac45c7f6f3 ro rhgb quiet LANG=en_US.UTF-8`
  - initrd和initrd16
    - 加载ramdisk文件。如`initrd /initramfs-0-rescue-d13bce5e247540a5b5886f2bf8aabb35.img`
- 如何用grub启动Windows：
```
insmod ntfs
set root=(hdX,gptX)
chainloader (${root})/EFI/Microsoft/Boot/bootmgfw.efi
boot
```



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
