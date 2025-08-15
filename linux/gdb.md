# gdb

## commands

``` bash
gdb <executable>
gdb --core <core_file> <executable>

b <breakpoint>

bt # backtrace

info sharedlibrary

info inferior

!readelf -S <path_to_app>

!cat /proc/<proc_id>/maps

disassemble

ni

disp /3i $pc # display $pc register

info files
info registers

break write if $rsp==2

watch

x # observe memory
info locals
pt #observe data structs
finish 
frame

info threads
thread #x
thread apply all bt

x /10gx $sp
x /16ga $sp # (g: display hex; a: automatic match symbols)

```

## DWARF debugging information format

/etc/apt/sources.list.d/ubuntu.source -> add deb-source to each item.

Download symbols and source files for ubuntu packages: [official page](https://documentation.ubuntu.com/server/explanation/debugging/debug-symbol-packages/)

## core dump

``` bash
ulimit -c unlimited
# add this to .bashrc
sudo apt install systemd-coredump

# list coredumps
coredumpctl list

# coredumps are located at /var/lib/systemd/coredump/xxxxx.zst
# uncompress:
uzstd <file>


# change default location:


```
