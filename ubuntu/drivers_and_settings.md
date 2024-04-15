驱动和配置
=======

显卡驱动
-------
### AMD显卡驱动简介：
- 目前主流显卡驱动：AMDGPU和AMDGPU-PRO
- 上一代显卡驱动：Radeon和Vulkan
- AMDGPU为开源，已经整合到Linux内核；AMDGPU-PRO为闭源。但两者性能差异不大。大多数情况开源的驱动足够。

### 检查正在使用的显示驱动：
```sh
sudo lshw -c video
```
```
  *-display                 
       description: VGA compatible controller
       product: Renoir
       vendor: Advanced Micro Devices, Inc. [AMD/ATI]
       physical id: 0
       bus info: pci@0000:04:00.0
       logical name: /dev/fb0
       version: c6
       width: 64 bits
       clock: 33MHz
       capabilities: pm pciexpress msi msix vga_controller bus_master cap_list fb
       configuration: depth=32 driver=amdgpu latency=0 resolution=3840,2160
       resources: irq:45 memory:d0000000-dfffffff memory:e0000000-e01fffff ioport:e000(size=256) memory:fe600000-fe67ffff
```

OR

```sh
sudo lspci -nnk | grep -i vga -A4
```
```
04:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD/ATI] Renoir [1002:1636] (rev c6)
        Subsystem: Tongfang Hongkong Limited Renoir [1d05:109f]
        Kernel driver in use: amdgpu
        Kernel modules: amdgpu
04:00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] Renoir Radeon High Definition Audio Controller [1002:1637]
```

OR

打开Ubuntu的系统设置->About  
在Graphic一行中查看显卡型号。如果正确安装驱动，应该显示显卡型号（Renoir）。否则显示类似llvm之类的通用驱动。  



### 安装驱动
(update: 内核已经更新至6.5,驱动已经内置)  
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
(更新：新版内核已经可以用键盘Fn快捷键控制屏幕亮度)
目前没有找到好的使用快捷键调整屏幕亮度的方法。可用的方法为：
```sh
xrandr | grep " connected" | cut -f1 -d " "
# output is the name of the connected monitor. In our case 'eDP'
xrand --output eDP --brightness 0.5
```
