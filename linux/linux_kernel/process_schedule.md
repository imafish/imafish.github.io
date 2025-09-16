# process schedule

## user priority vs. realtime priority

``` bash
#      round robin        thread count
sudo chrt -rr 99 <process> 2 2
```

## gesilk


## kernelshark

## trace-cmd

`trace-cmd` to capture kernel events

## /....

## perf

perf to capture events in user executables

`sudo perf record -e LLC-load-misses <executable>`

----
capture data using trace-cmd or perf then visualize using kernelshark
