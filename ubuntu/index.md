一直想使用Linux作为日常桌面，可由于做的是Windows开发，之前只能用虚拟机尝试Linux。  
最近购入了一台新笔记本（机械革命 code 01），性能还算可以。打算尝试使用Ubuntu作为桌面，在虚拟机里搭建Windows开发环境。  
在这里记录一下折腾的过程。日后如果需要重做作为参考。

[[_TOC_]]



梯子
=======

目前使用的梯子provider为[nplus](nplus.icu)  
客户端为clash，项目地址：[dreamacro/clash](https://github.com/Dreamacro/clash)

nplus让人难受的地方是只支持clash 0.x，而clash最新1.x版本使用了新格式的配置文件。所以只能找旧的clash release使用，还不能开启自动升级。


安装clash
-------

到 https://github.com/Dreamacro/clash/releases 下载linux-amd的安装包。注意不要选择1.x版本的，选择0.x版本。  
解压里面的文件到~/bin文件夹。  
给文件添加执行权限。  
直接运行文件即可启动clash


配置clash
-------
clash需要两个配置文件：~/.config/clash/config.yaml和~/.config/clash/Country.mmdb  
其中Country.mmdb需要从Clash for Windows中复制（TODO: 寻找可用下载地址）  
config.yaml文件则从nplus.icu网站获取URL进行下载  

打开下载的config.yaml文件，找到“external-controller: '0.0.0.0:9090'”一行。将IP修改为127.0.0.1

访问 http://clash.razord.top/ 这是clash的网页端配置接口。输入刚才设置的IP和端口号，进入配置页面。  
如果配置正确，应该能够看到代理列表。  
点击右侧“Speed Test”，进行速度测试，然后在第一列选择合适的代理。

至此梯子已经搭好，配置Chrome插件或系统代理来使用梯子。


clash自启动
-------
详见[clash](clash.md)  

NOTE: 由于目前没有找到clash的UI工具，无法配置默认代理，每次都使用clash.razord.top十分不方便。  
当前的办法是编辑下载的config.yaml文件，在proxy数组中把想用的代理挪到第一位。这样clash就启动时会自动选择该代理。


自动更新配置及IP数据库
-------


备选机场
-------
查资料的时候发现了几个其他备选机场。希望需要的时候不会突然消失不见：  
[喷射流](https://jetstream.zendesk.com/hc/zh-tw): 使用clash作为首选linux client。或许对新版本的支持会好一些？  
[DuangCloud](https://www.dcrelay.me/)：卡在注册登录页面



Google Pinyin
=======

```sh
sudo apt-get install fcitx-googlepinyin
```
安装之后的配置：

按win键，输入language support并打开  
在右下角输入法系统下拉菜单，选择fcitx（默认为ibus）  
重启  
重启之后在右上角状态栏点击键盘图标，选择configure进入配置界面  
点击输入方法设置左下角的+号，进入添加输入方法界面。取消“只显示当前语言”选项的勾选，输入pinyin搜索到系统现有的拼音输入法。选择Google Pinyin并点击OK确认。  
关闭设置，谷歌输入法配置完成。可以点击右上角状态栏的键盘图片切换到谷歌输入法，切换输入法的快捷键是ctrl+space，可以在刚关闭的输入方法设置界面里第二项Global Config里修改快捷键。


reference: https://blog.csdn.net/a805607966/article/details/105874756



驱动和配置
=======


显卡驱动
-------

### AMD 显卡驱动简介：
- 目前主流显卡驱动：AMDGPU和AMDGPU-PRO
- 上一代显卡驱动：Radeon和Vulkan
- AMDGPU为开源，已经整合到Linux内核；AMDGPU-PRO为 闭源。但两者性能差异不大。大多数情况开源的驱动足够。

### 检查正在使用的显示驱动：
```sh
sudo lshw -c video
```
TODO：sample output


```sh
sudo lspci -nnk | grep -i vga -A4
```
TODO：sample output

打开Ubuntu的系统设置->About  
在Graphic一行中查看显卡型号。如果正确安装驱动，应该显示显卡型号（Renoir）。否则显示类似llvm之类的通用驱动。  
TODO：sample screenshot


### 安装驱动
开源AMDGPU驱动已经整合到linux kernel里。不过要支持4800H的核显（Renoir），需要至少5.6以上版本的Kernel。  
当前Ubuntu 20.04 LTS的内核版本为5.4，所以需要手动安装需要的版本。  
来到 https://kernel.ubuntu.com/~kernel-ppa/mainline/ , 选择合适的内核版本。建议不需要选择过高的版本，可能会有兼容问题。  
下载linux-headers-\*.deb; linux-headers-\*_all.deb; linux_image_unsigned*.deb; linux-modules-*.deb  
使用
```sh
sudo dpkg -i linux-*.deb
```
安装。重启之后检查内核版本和显卡驱动状态。

手动安装的内核为unsigned状态。如果开启了BIOS的secure boot功能，内核将无法加载。  
解决方法为：
1. 给内核文件签名
2. 关闭secure boot
目前暂时使用第二种临时解决一下。TODO：以后更新签名内核的步骤


触摸板三指滑动
-------
fusuma是一个使用ruby编写的触摸板监控程序。配合xdotool可以实现三指滑动切换程序、桌面等操作。  
- 具体安装参考 https://github.com/iberianpig/fusuma  
- 示例配置文件：[fusuma config](fusuma.config.yml)
- 参考clash部分，将fusuma设置为系统service自动启动。（此处有问题，fusuma设置为系统服务之后无法捕获触摸板）
- 修改.bash_profile将fusuma设置自动启动。


合盖休眠
-------
似乎安装好5.6内核和显卡驱动这个笔记本已经支持了合盖休眠。观察中。

参考： https://www.cnblogs.com/pipci/p/12544232.html  
https://www.cnblogs.com/feipeng8848/p/9693137.html

屏幕亮度调节
-------
目前没有找到好的使用快捷键调整屏幕亮度的方法。可用的方法为：
```sh
xrandr | grep " connected" | cut -f1 -d " "
# output is the name of the connected monitor. In our case 'eDP'
xrand --output eDP --brightness 0.5
```


常用软件
=======

WPS
-------
[WPS](http://linux.wps.com/)  
WPS启动时候会提示缺少字体。可以到[这里](https://github.com/IamDH4/ttf-wps-fonts)下载安装。

VLC
-------
VLC: `sudo apt install vlc`

目前vlc已知的bug：  
当播放视频时，点击右上角的‘x’关闭窗口，vlc会假死没有响应，只能强行杀掉。解决方法是播放完视频按ctrl+Q退出而不要按‘x’。

### VLC自动搜索、下载并加载字幕
TODO: Working on it...


桌面美化
=======

Ubuntu当前版本（20.04）使用gnome桌面，gnome-tweaks工具可以很好的配置。  
```
sudo apt install gnome-tweaks gnome-shell-extensions gnome-shell-extension-dash-to-panel gnome-shell-extension-autohidetopbar gnome-shell-extension-appindicator gnome-shell-extension-ubuntu-dock
```
桌面主题可以从[gnome-look](https://www.gnome-look.org/)下载。窗口主题使用的是yaru，鼠标主题使用Bibata-Modern-DarkRed

壁纸使用variety进行更换。配置文件：[variety.conf](./variety.conf)



TODO
=======
- 梯子
  - 梯子软件和配置
  - go mirror
  - github mirror

- 驱动和配置
  - ~~显卡驱动~~
  - 亮度调节/夜晚模式
  - 触摸板
    - 三指滑动
    - 禁用触摸板
  - 键盘快捷键
  - 合盖休眠

- 备份
  - 系统备份
  - 资料备份
  - 虚拟机备份
  - 备份恢复
  - A script to backup automatically.

- 电池优化

- 常用软件
- 开发环境
  - VS code
    - .NET core 开发与调试
    - Markdown CSS
  - Visual Studio ??
