# gdb

## Basics

### start debugging a program

- start gdb with executable to debug

``` shell
gdb <executable>
```

- start gdb with an executable and a core file

``` shell
gdb --core <core_file> <executable>
# or
gdb <executable> <core_file>
```

- start gdb, then load an executable and a core file

``` shell
gdb

(gdb) file <executable>
(gdb) core <core_file>
```

### load shared libraries and give source code root directory

``` shell
gdb <executable>

(gdb) set solib-search-path <path_to_shared_libs>
(gdb) directory <path_to_root_of_source_code>
(gdb) core <path_to_coredump>
```

### executable shell commands and goes back to gdb

``` shell
(gdb) !<commands>

# e.g.
(gdb) !ls
(gdb) !readelf -S <path_to_app>
(gdb) !cat /proc/<proc_id>/maps
```

## Registers

refer to registers using `$`, for example `$pc`

### x86 registers

- x86 Architecture (32-bit)
  - `EAX`: Accumulator Register
  - `EBX`: Base Register
  - `ECX`: Counter Register
  - `EDX`: Data Register
  - `ESI`: Source Index
  - `EDI`: Destination Index
  - `EBP`: Base Pointer (often used for stack frames)
  - `ESP`: Stack Pointer
  - `EIP`: Instruction Pointer (points to the next instruction to be executed)
  - `EFLAGS`: Flags Register (contains status flags)
- x86_64 Architecture (64-bit)
  - `RAX`: Accumulator Register
  - `RBX`: Base Register
  - `RCX`: Counter Register
  - `RDX`: Data Register
  - `RSI`: Source Index
  - `RDI`: Destination Index
  - `RBP`: Base Pointer (often used for stack frames)
  - `RSP`: Stack Pointer
  - `RIP`: Instruction Pointer
  - `RFLAGS`: Flags Register (contains status flags)
- Additional Registers in x86_64
  - `R8` to `R15`: Additional general-purpose registers (`R8`, `R9`, `R10`, `R11`, `R12`, `R13`, `R14`, `R15`)
  - `XMM0` to `XMM15`: SIMD registers for floating-point operations (used in SSE instructions)
  - `YMM0` to `YMM15`: SIMD registers for AVX instructions
  - `ZMM0` to `ZMM31`: SIMD registers for AVX-512 instructions (if supported)

### arm64 registers

- General-Purpose Registers
  - `X0` to `X30`: General-purpose registers (`X0` is often used for the first argument to functions, `X1` for the second, and so on).
  - `SP`: Stack Pointer (`X31`, but often referred to as `SP`).
  - `LR`: Link Register (`X30`, used to store the return address for function calls).
  - `PC`: Program Counter (points to the next instruction to be executed).
- Special Registers
  - `NZCV`: Condition Flags Register (contains the Negative, Zero, Carry, and Overflow flags).
  - `FP`: Frame Pointer (often `X29`, used to point to the current stack frame).
  - `SPSR`: Saved Program Status Register (used to save the state of the program status when handling exceptions).

## Basic commands

``` shell
# backtrace -- stacks
(gdb) bt # backtrace

(gdb) info sharedlibrary

# inferiors are basic units of a gdb session, commonly known as 'process', or 'executable'
(gdb) info inferior

# local variables
(gdb) info locals

# show disassemble code
(gdb) disassemble

# list all loaded files (shared libraries, executable, core file, etc)
(gdb) info files

(gdb) info registers
```

## Show variables

``` shell
(gdb) print <variable>

# display the variable value when the execution stops
(gdb) display <variable>

# observer memory
(gdb) x <address>

# break and stop when variable value changes
(gdb) watch <variable>

# observe data structures
(gdb) pt <variable>
```

### format

Basic Syntax

``` shell
(gdb) print /[format] expression
```

Format Specifiers

Here are some common format specifiers you can use:

- **d**: Signed decimal integer
- **u**: Unsigned decimal integer
- **x**: Hexadecimal integer
- **o**: Octal integer
- **t**: Binary integer
- **f**: Floating-point number
- **c**: Character
- **s**: String

``` shell
(gdb) print /d my_variable
(gdb) print /5d my_variable
(gdb) print /0.2f my_float_variable
(gdb) print /s my_string_variable
```

### more format for `display`

``` shell
# display current and 3 more disassemble instructions in PC
(gdb) disp /3i $pc
```

### more format for `x`

``` shell
(gdb) x/[count][format] [address]
```

- `format`: Specifies how to display the memory contents (e.g., hexadecimal, decimal, etc.).
- `count`: The number of units to display (e.g., number of bytes, words, etc.).
- `address`: The starting address in memory from which to read.

Format Specifiers

Here are some common format specifiers you can use with the x command:

- **b**: Byte (8 bits)
- **h**: Halfword (16 bits)
- **w**: Word (32 bits)
- **g**: Giant word (64 bits)
- **x**: Hexadecimal format
- **d**: Signed decimal format
- **u**: Unsigned decimal format
- **o**: Octal format
- **t**: Binary format
- **c**: Character
- **s**: String (null-terminated)
- **a**: follow symbols

``` shell
(gdb) x /10gx $sp
(gdb) x /16ga $sp # (g: display hex; a: automatic match symbols)

(gdb) x/5dw 0x7fffffffe000
(gdb) x/4ho 0x7fffffffe000
(gdb) x/s 0x7fffffffe000
```

## Breakpoints

### list breakpoints

``` shell
# create with line number
(gdb) b <line_number>

# create with a line in another file
(gdb) b <file>:<line_number>

# create with a function name
(gdb) b <method_name>

# break on a condition
(gdb) b <location> if x > 10
(gdb) b <location> if $sp=2

# list breakpoints
(gdb) info breakpoints

# delete a breakpoint
(gdb) delete <breakpoint_number>
```

### temporary breakpoints

You can set a breakpoint that automatically deletes itself after being hit using `tbreak`

``` shell
(gdb) tbreak <func>
```

### Watchpoints

If you want to stop execution when a variable changes, you can set a watchpoint:

``` shell
(gdb) watch variable_name
```

## Execution

### next

- **Command**: next (or n)
- **Function**: Executes the next line of code in the current function. If the next line is a function call, next will execute the entire function without stepping into it, and then stop at the next line in the current function.
- **Use Case**: Use next when you want to execute the current line and move to the next line without going into any called functions.

### step

- **Command**: step (or s)
- **Function**: Executes the next line of code, but if that line contains a function call, step will enter that function and stop at the first line of the called function.
- **Use Case**: Use step when you want to debug inside a function and see how it executes line by line.

### finish

- **Command**: finish
- **Function**: Continues execution until the current function returns. When the function returns, GDB will stop and show you the return value of the function and the line of code that follows the function call in the calling function.
- **Use Case**: Use finish when you are inside a function and want to quickly run to the end of that function without stepping through each line.

### continue

- **Command**: continue (or c)
- **Function**: Resumes the execution of the program after it has been stopped (e.g., at a breakpoint or after a signal). The program will run until it hits the next breakpoint, a signal, or the program exits.
- **Use Case**: Use continue when you want to keep running the program until it hits another breakpoint or finishes execution.

### run

- **Command**: run (or r)
- **Function**: Starts the execution of the program from the beginning. You can also pass command-line arguments to the program when using run.
- **Use Case**: Use run when you want to start the program from the beginning, typically after making changes to the code or after stopping the program.

### ni

- **Function**: next disassembly instructions
- **Use Case**: use when you want to execution code in assembly

## Threads (TODO)

``` shell
(gdb) frame
(gdb) info threads
(gdb) thread #x
(gdb) thread apply all bt
```

## Assembly (TODO)

``` shell
(gdb) disassemble
(gdb) ni
```

## more

see [core dumps](./core_dump.md)
