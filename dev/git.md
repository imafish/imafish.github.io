# Git

## 设置Git代理

1. http / https 协议：
``` sh
git config --global https.https://github.com.proxy socks5://127.0.0.1:1080
git config --global http.https://github.com.proxy socks5://127.0.0.1:1080
git config --global http.proxy socks5://127.0.0.1:1080
git config --global https.proxy socks5://127.0.0.1:1080
```

2. ssh 协议
``` sh
//对于使用git@协议的，可以配置socks5代理
//在~/.ssh/config 文件后面添加几行，没有可以新建一个
//socks5
Host github.com
User git
ProxyCommand connect -S 127.0.0.1:1080 %h %p

//http || https
Host github.com
User git
ProxyCommand connect -H 127.0.0.1:1080 %h %p
```
