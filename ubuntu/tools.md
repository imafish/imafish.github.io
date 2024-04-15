# 常用工具


Google Pinyin
-------

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



Gnome Extensions
-------
gnome extensions很好的拓展了gnome桌面的功能。ubuntu22.04自带extension管理工具。在activities界面搜索extension即可打开设置窗口。
`sudo apt install gnome-shell-extensions`安装常用extension; `sudo apt install gnome-shell-extension`+`tab`安装其他。  
下载extensions: [https://extensions.gnome.org/](https://extensions.gnome.org/)

桌面美化
-------
Search themes, cursor pointers, icons at [https://www.gnome-look.org/browse/](https://www.gnome-look.org/browse/).
To customize themes, install gnome tweaks by `sudo apt install gnome-tweaks`, then start: `gnome-tweaks`

curently in use:
- Applications: Yaru-olive
- Cursor: Bibata-Modern-DarkRed
- Icons: Yaru-olive
- Shell: Yaru-Green-light
- Sound: Custom
