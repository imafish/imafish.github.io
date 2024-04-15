# 把Ubuntu安装到电脑里

目标：机械革命 Code 01, AMD Ryzen 4800H, 32GB.


[[_TOC_]]



梯子
-------
详情见[proxies](./proxies)
- 目前客户端为clash。项目地址：[dreamacro/clash](https://github.com/Dreamacro/clash)。已经跑路不再更新。
- 考虑使用[v2ray](https://github.com/v2ray/v2ray-core/releases).
- 机场服务: [socloud.me](https://socloud.me).


### 备选机场
[喷射流](https://jetstream.zendesk.com/hc/zh-tw)
[DuangCloud](https://www.dcrelay.me/)：卡在注册登录页面


工具
-------
详情见[tools](./tools)

- Input methods:
  - 目前使用Google pinyin + fcitx
  - 备用: sogou pinyin
  - 备用: built-in Ibus Chinese-Pinyin
  - 备用: 希望gboard出一个Linux版本




驱动和配置
-------
详见[drivers_and_settings](./drivers_and_settings)

- 显卡
- 触摸板（三指滑动支持）
- 合盖休眠
- 屏幕亮度



常用软件
-------
详情见[software](./software)

- 办公：WPS
- 视频播放：VLC
- 壁纸： variety
- 终端： byobu




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
  - ~~梯子软件和配置~~
  - go mirror
  - github mirror

- 驱动和配置
  - ~~显卡驱动~~
  - ~~亮度调节/夜晚模式~~
  - 触摸板
    - ~~三指滑动~~
    - 禁用触摸板
  - ~~键盘快捷键~~
  - ~~合盖休眠~~

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
    - Markdown CSS
