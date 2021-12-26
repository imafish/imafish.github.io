# 输入法

## 输入法框架
输入法框架用来加载输入法。当前Ubuntu默认的框架为ibus。而中文输入法大多使用fcitx。

-------
## Google Pinyin
Google拼音的优势在于稳定。在绝大多数Linux发行版都可以使用。  
劣势在于词库和功能性。

### 安装和配置
安装：  
```
sudo apt install fcitx-googlepinyin
```

启动fcitx输入法框架：  
```
im-config
```

在弹出的窗口选择OK->YES  
然后在框架列表里选择fcitx并确认。

**重新启动**！

输入命令`fcitx-config-gtk3`启动fcitx的配置窗口，添加google拼音。


### 词库
导入搜狗拼音的词库。

-------
## Sougou Pinyin
