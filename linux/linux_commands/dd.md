# dd

dd copies from input file (device) to output file (device)

example:

``` bash
dd if=/dev/zero of=/var/cache/swapfile bs=1G count=128
# if: input file
# of: output file
# bs: block size
```
