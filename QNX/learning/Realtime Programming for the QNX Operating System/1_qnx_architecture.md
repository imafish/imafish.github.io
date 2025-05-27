# QNX Architecture

## The Microkernel

### The microkernel handles the following

1. scheduling
2. (inter)-processor interrupts (IPI) -- IPI thread
3. processor exceptions
4. interprocess communication
5. kernel calls -- in user thread
6. resource management
7. timer
8. idle thread

### The three thread always running in the microkernel per processor

1. IPI
2. clock interrupts
3. idle thread

### Threads in running kernel code CAN be pre-empted

## Scheduling

1. Scheduling is per thread
2. higher priority pre-empts lower priority
3. priority is from 0~255
4. priority 0, 254, 255 are reserved by system

### Thread states

- Runnable
  - Running
  - Waiting
- Blocked

### Cluster

A cluster is:

- a set of related CPU cores
- Defined by the startup code in the BSP
- Something used to specify where a thread is allowed to run

## Process Manager

procnto is QNX

- proc for the process manager
- nto for neutrino micro kernel
- they share the same memory space, but behaves differently (TODO: process manager not running in elevated privilege?)
- the process manager is reached using messages

### Process Manager is responsible for

1. packaging of groups of threads together into processes
   1. process creation and termination
      1. posix_spawn / fork / exec
      2. loads ELF executables
2. memory management: memory allocation, address space management
   1. shared memory
3. pathname management
   1. in QNX, this is process location
4. several resource managers
   1. /proc
   2. /dev/shmem
   3. /dev/sem
5. system state notifications
6. system information

### Memory management: Virtual address model

1. to access physical (hardware) memory addresses, you must create a virtual mapping
2. all the processes share the underlying physical memory address space.
3. user space is 0-512GB
4. kernel is 512GB+
5. this makes kernel calls cheaper

### pathname management

1. When QNX Neutrino starts up, all pathname spaces are owned by the process manager.
2. Any request for file or device pathname resolution are handled by the process manager.
