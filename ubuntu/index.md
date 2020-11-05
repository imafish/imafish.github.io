一直想使用Linux作为日常桌面，可由于做的是Windows开发，之前只能用虚拟机尝试Linux。  
最近购入了一台新笔记本（机械革命 code 01），性能还算可以。打算尝试使用Ubuntu作为桌面，在虚拟机里搭建Windows开发环境。  
在这里记录一下折腾的过程。日后如果需要重做作为参考。

[[_TOC_]]

# 梯子

目前使用的梯子为[nplus](nplus.icu)  
客户端为clash，项目地址：[dreamacro/clash](https://github.com/Dreamacro/clash)

nplus让人难受的地方是只支持clash v0.x，而clash最新v1.x版本使用了新格式的配置文件。所以只能找旧的clash release使用，还不能开启自动升级。

__TO BE CONTINUED...__


__P.S.__: 查资料的时候发现了几个其他备选机场。希望需要的时候不会突然消失不见：  
[喷射流](https://jetstream.zendesk.com/hc/zh-tw): 使用clash作为首选linux client。或许对新版本的支持会好一些？  
[DuangCloud](https://www.dcrelay.me/)：卡在注册登录页面


# Google Pinyin

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

# 驱动

## 显卡驱动

**检查正在使用的显示驱动：**  
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


**安装驱动**  
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


# TODO
- 梯子
  - 梯子软件和配置
  - go mirror
  - github mirror

- 驱动
  - 显卡驱动
  - 亮度调节/夜晚模式
  - 触摸板驱动 （禁止触摸板）
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
