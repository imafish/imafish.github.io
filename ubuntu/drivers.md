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
