# Heap diagnostic tools


## valgrind

Valgrind is a tool to detect heap corruption

It hooks the binary (malloc, etc.) and prints analysis report.

### installation and usage

``` bash
sudo apt install valgrind
valgrind <binary>
```

## Asan

``` bash
gcc -fsanitizer=address <source>
```

## heaptrack
