# swap

## How to create a file as swap partition

``` bash
# Create a swap file
dd if=/dev/zero of=/swapfile bs=1G count=128

# change owner, group and permission
sudo chown root:root /swapfile
sudo chmod 600 /swapfile

# format
sudo mkswap /swapfile

# check current swap areas
sudo swapon --show

# enable swap
sudo swapon /swapfile

# add to fstab:
vi /etc/fstab
# add line: /swapfile none swap sw 0 0
```

## vm.swapiness

vm.swappiness is a kernel parameter in Linux that controls how aggressively the system swaps memory pages between RAM and the swap space (usually a disk partition or file). It determines the balance between using RAM and swapping to disk, with higher values indicating a greater tendency to swap. The default value is typically 60, but it can range from 0 to 100 or even 200, depending on the system.
