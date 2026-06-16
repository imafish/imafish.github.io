# core dumps

## DWARF debugging information format

/etc/apt/sources.list.d/ubuntu.source -> add deb-source to each item.

Download symbols and source files for ubuntu packages: [official page](https://documentation.ubuntu.com/server/explanation/debugging/debug-symbol-packages/)

## create core dumps in linux

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
