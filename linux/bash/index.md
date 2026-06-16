# Bash usage tips

[A very good tutorial](https://tldp.org/LDP/Bash-Beginners-Guide/html/index.html).

## `stat`: get file size

``` shell
stat -c%s FILENAME
```

From [man stat](https://linux.die.net/man/1/stat):

> %s total size, in bytes
