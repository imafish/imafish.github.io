# Resource Managers

## Overview of Resource Managers

### What is a resource manager?

- a program that looks like it is extending the operating system by:
  - creating and managing a name in the pathname space
  - providing a POSIX interface for clients (e.g. `open()`, `read()`, `write()`, ...)
- can be associated with hardware (such as a serial port, or disk drive)
- or can be a purely software entity (such as queuing or logging)

### Pathname space

![x](../../../assets/QNX/resource_manager/pathname_space.png)

The prefix tree:

- is the root of the pathname space
  - every name in the pathname space is a descendant of some entry in the prefix tree
- is maintained by the Process Manager
- Resource Managers add and delete entries
- associates a `pid`, `chid`, and `handle` with a name
- is searched for the longest slash-delimited whole-word matching prefix

- The mapping can be observed / debugged by looking into path `/proc/mount`

![x](../../../assets/QNX/resource_manager/observe_pathname.png)

#### Example: open `/home/bill/spud.dat`

![x](../../../assets/QNX/resource_manager/pathname_example.png)

### When a client requests a service

``` C++
fd = open("/dev/ser1", O_RDWR);
// or
fp = fopen("/home/bill/abc", "w");
// or
mg = ma open("/myqueue", O_RDONLY);
```

which results in the client's library code sending a message to the process manager...

### opening a resource manager

![x](../../../assets/QNX/resource_manager/opening_a_pathname.png)

1. `open()` sends a "query" message
2. Process Manager replies with who is responsible (`pid`, `chid`, `handle`)
3. `open()` establishes a connection to the specified resource manager (`pid`, `chid`), and sends an open message (containing the handle)
4. resource manager responds with status (pass/fail)

- All further communication goes directly to the resource

### Resource managers are built on message passing

![x](../../../assets/QNX/resource_manager/communicating_with_resmgr.png)

1. client calls the POSIX `write()`
2. this builds and sends a message
3. the resource manager receives and processes the `write` message appropriately
4. the resource manager replies with a result and this is returned to the client from `write()`

### A resource manager performs the following steps

- creates a channel
- takes over a portion of the pathname space
- waits for messages & events
- processes messages, returns results

### There are three major types of messages

- Connect messages:
  - pathname-based (eg: `open("spud. dat", ...)`)
  - may create an association between the client process and the resource manager, which is used later for I/O messages
- I/O messages:
  - file-descriptor- (`fd`-) based (eg: `read(fd, ...)`)
  - rely on association created previously by connect messages
- Other:
  - pulses, private messages, etc

### Resource manager messages

- Defined in `<sys/iomsg.h>`

#### Connect Messages

- have a type of `_IO_CONNECT`
- differentiated by subtype:

``` C++
// client call        message
    open()        // _IO_CONNECT_OPEN
  unlink()        // _IO_CONNECT_UNLINK
  rename()        // _IO_CONNECT _RENAME

#include <sys/iomsg.h>
```

#### I/O Messages

- all have different message types:

``` C++
// client call        message
    read()          // _IO_READ
    write()         // _IO_WRITE
    close()         // _IO_CIOSE
devctl(), ioctl()   // _IO_DEVCTI

#include <sys/iomsg.h>
```

#### Other I/O messages

``` C++
_IO_NOTIFY,
_IO_STAT,
_IO_SPACE,
_IO_PATHCONF,
_IO_ISEEK,
_IO_CHMOD,
_IO_CHOWN,
_IO_UTIME,
_IO_OPENED,
_IO_EDINFO,
_IO_LOCK,
_IO_TRUNCATE,
_IO_SHUTDOWN,
_IO_DUP,
```

### resource-manager library

Writing resource managers is simplified greatly with a resource-manager library that:

- simplifies main receive loop (table-driven approach)
- has default actions for all message types

![x](../../../assets/QNX/resource_manager/resource_manager_library_overview.png)

![x](../../../assets/QNX/resource_manager/resource_manager_library_zoom_in.png)

Message-handling functions:

- may access client data
  - data already in the receive buffer
  - get more data if necessary
- must either:
  - reply to the client with:
    - an error
    - a success status without data
    - a success status and data
- or:
  - delay responding to the client until later
