# clash

[dreamacro/clash](https://github.com/Dreamacro/clash)

## 安装

[可执行文件下载地址](https://github.com/Dreamacro/clash/releases/tag/premium)  
[让clash以service形式运行](https://github.com/Dreamacro/clash/wiki/clash-as-a-daemon)  

## 配置

clash默认使用config.yaml为配置文件。
通常，不应该经常修改主配置文件，而梯子地址经常变化。我们可以使用`proxy-provider`关键字定义一个梯子列表，这个列表可以存在文件或者云端。这样就可以在不修改主配置文件的情况更新梯子。
例如：  
```
proxy-providers:
  nplus:
    type: file
    path: ./nplus.yaml
    health-check:
      enable: true
      interval: 108000
      url: http://www.gstatic.com/generate_204
```

然后在接下来的proxy-groups，引用这个proxy-providers  
```
proxy-groups:
  - name: LOADBALANCE
    type: load-balance
    use:
      - nplus
    url: http://www.gstatic.com/generate_204
    interval: 300
```

### GUI
1. Dreamacro还有一个clash-dashboard的项目：https://github.com/Dreamacro/clash-dashboard，待研究。
2. [razor.clash](https://clash.razord.top) 提供在线的clash配置UI。需要clash服务打开控制端口（`external-controller: 127.0.0.1:9090`）

## xplus.icu

xplus.icu下载梯子的地址为：https://sub.v2hub.icu/link/OjT5CvEfdurTz6wV?clash=1  
地址可能很快会失效。官方网站现在已经不提供该下载地址。  
网站似乎在向其他编码迁移。比如https://sub.v2hub.icu/link/OjT5CvEfdurTz6wV?config=1下载下来的似乎是v2ray编码的梯子列表。  
未来可能需要将该格式转换为clash格式。工具为(https://github.com/tindy2013/subconverter)

从这个地址下载的文件为一个旧版本的clash配置文件。需要从中提取出梯子的列表，另存为nplus.yaml，放在`/etc/clash`文件夹下。
