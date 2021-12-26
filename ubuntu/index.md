# Ubuntu折腾笔记

[[_TOC_]]

-------
## 序
告别了Windows开发，终于可以格式化电脑，装上Ubuntu作为主力桌面了。  
目前Ubuntu作为桌面的主要问题有：
1. 微信：至今还没有Linux下的原生版本，使用wine勉强可以运行。
2. 迅雷：同上
3. 输入法：google拼音已经多年没有更新了；搜狗拼音也和Windows平台的差了好几版本。但是还算可用。
4. 游戏：桌面游戏大多没有Linux版本。还好Steam有Linux版本，上面有不少好玩的游戏。不少模拟器也都支持跨平台。另外还有wine和一些其他方案尝试在Linux下原生运行Windows游戏。

### 软件
日常软件在Ubuntu下大多有较好的选择。
1. 视频播放
2. 看图
3. 截图
4. 基础图片编辑
5. 下载（BT）
6. 浏览器
7. 文本处理
8. 简单办公
9. 输入法
10. 梯子

### 工作、开发
1. IDE
2. 包管理器的代理设置
3. 容器 -- docker
4. 开发平台（kubernetes）

### 游戏
1. 模拟器
2. Steam
3. wine


-------
## 安装系统

- 和Windows并存
- Grub


-------
## 使用脚本初始化

该脚本能够安装一些常用软件，并自动进行一些配置，包括shell的启动脚本、VIM的设置，等等。

- 安装git：`sudo apt install git-all`
- 生成ssh key：`ssh-keygen -C '<user identifier> -t rsa -b 4096`
- 创建目录：`mkdir src && cd src`
- 下载脚本：`git clone git@github.com:imafish/ubuntu_scripts.git`
- 运行：`cd ubuntu_scripts; sudo ./all.sh`



-------
## 驱动与配置

### 挂载硬盘
挂载硬盘可以使用传统的`fdisk` + `mkfs` + `mount` + `fstab` [reference](https://www.answertopia.com/ubuntu/adding-a-new-disk-drive-to-an-ubuntu-system/)  
也可以使用ubuntu自带的GUI工具`disks`，这个工具足够完成一般的硬盘挂在任务。但是设置完毕之后（可能）需要重启才会真正加载新硬盘。

### 显卡驱动
目前Ubuntu内核可以完美支持AMD的已知显卡（4800H的Renoir和独立显卡Raedon系列）。  
如遇到不支持的显卡可参考[显卡](./drivers.md#video_card)

### 触摸板三指滑动
fusuma是一个使用ruby编写的触摸板监控程序。配合xdotool可以实现三指滑动切换程序、桌面等操作。  
- 具体安装参考 https://github.com/iberianpig/fusuma
- 示例配置文件：[fusuma config](fusuma.config.yml)
- 自动启动：
  - 参考clash部分，将fusuma设置为系统service自动启动。（此处有问题，fusuma设置为系统服务之后无法捕获触摸板）
  - 修改.bash_profile将fusuma设置自动启动。

### 合盖休眠
安装好驱动的笔记本会自动支持了合盖休眠。观察中。  
参考： https://www.cnblogs.com/pipci/p/12544232.html  
https://www.cnblogs.com/feipeng8848/p/9693137.html

### 屏幕亮度调节
安装好显卡驱动后，可以使用笔记本键盘的快捷键调整屏幕亮度。  
使用命令行调节：  
```sh
xrandr | grep " connected" | cut -f1 -d " "
# output is the name of the connected monitor. In our case 'eDP'
xrand --output eDP --brightness 0.5
```



-------
## 软件

### 梯子
客户端为clash，项目地址：[dreamacro/clash](https://github.com/Dreamacro/clash)  
目前使用的梯子provider为[xplus](https://xplus.icu)  
详见[clash](./clash.md)

### chrome
chrome可以用ubuntu_scripts自动安装

#### 插件：SwitchyOmega
Rule List地址：https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt

#### 插件：TamperMonkey
脚本主要实现历史价格查询、视频下载、百度网盘直链下载等功能。
使用的脚本列表：
- 【玩的嗨】VIP工具箱,百度文库解析导出,全网VIP视频免费破解去广告,一站式音乐搜索下载,获取B站封面,下载B站视频等众多功能聚合 长期更新,放心使用
- 懒人专用，全网VIP视频免费破解去广告、全网音乐直接下载、百度网盘直接下载等多合一版。长期更新，放心使用。
- 百度网盘简易下载助手（直链下载复活版）

脚本下载网址：
- https://greasyfork.org/en
- https://www.tampermonkey.net/scripts.php


### 输入法
linux下常用的拼音输入法有Google和搜狗。  
[详见](./input_method.md)

### WPS
[WPS](http://linux.wps.com/)  
WPS启动时候会提示缺少字体。可以到[这里](https://github.com/IamDH4/ttf-wps-fonts)下载安装。

### VLC
安装: `sudo apt install vlc`  
目前vlc已知的bug：  
当播放视频时，点击右上角的‘x’关闭窗口，vlc会假死没有响应，只能强行杀掉。解决方法是播放完视频按ctrl+Q退出而不要按‘x’。

#### VLC自动搜索、下载并加载字幕
TODO: Working on it...



-------
## 个性化设置

### 壁纸
使用variety工具自动切换桌面壁纸。  
配置文件：[variety.conf](./variety.conf)

### 桌面风格 & 图标 & 鼠标指针
ubuntu自带的桌面风格让人看着不是很舒服，有一种用压抑感。鼠标指针也不怎么明显，经常找不到。

安装gnome-tweaks：  
```
sudo apt install gnome-tweaks \
    gnome-shell-extensions \
    gnome-shell-extension-ubuntu-dock \
    gnome-shell-extension-multi-monitors \
    gnome-shell-extension-dash-to-panel \
    gnome-shell-extension-workspaces-to-dock 
```
安装完毕后需要重启生效

从 https://www.gnome-look.org/browse/ 下载gnome桌面的主题包。  
shell的主题解压到`/usr/share/themes/`；图标和鼠标指针解压到`/usr/share/icons/`

打开gnome tweaks，在`Extensions`栏下打开`user themes`开关，这样在`Appearance`栏才能选择Shell的风格。  
然后来到Appearance栏，在右侧选择合适的主题。

当前使用：
- Applications: Yaru-Green-Light (from [Yaru-Colors](https://www.gnome-look.org/p/1299514/))
- Cursor: Bibata-Modern-DarkRed (from [Bibata Extra](https://www.gnome-look.org/p/1269768/))
- Icons: Yaru
- Shell: Yaru-Green-light (from [Yaru-Colors](https://www.gnome-look.org/p/1299514/))
- Sound: Yaru

### 字体


-------
## 搭建开发平台


