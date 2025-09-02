# Security Policy Basics

## Why security policies?

- individual developers don't, sometimes can't, know the final uses of what they are writing
  - therefore, they can't know the correct privileges to set/keep/drop
- system integrator has final responsibility for system security
- security policies put control of system security at the system integration level (overall policy for the entire system), not at the individual component level
  - developers do need to write their code to support this goal

## A security policy

- is a host-side text file that gets compiled into a target-side binary policy file
- primarily defines:
  - security types
    - these will be associated with run-time entities at run-time
    - most often, associated with processes
  - the privileges associated with each type, e.g.
    - map hardware memory
    - attach to an interrupt
    - connect to a channel in another process
    - change to a different type

## The software components involved are

- host-side:
  - secpolcompile - compile a text policy to a binary policy
- target-side:
  - secpolpush - install a binary policy in the kernel
  - secpol - examine a binary policy for debug purposes
  - libsecpol.so - AP| for examining and using the binary policy
  - secpolgenerate - tool to generate a text policy from a test system
  - secpollaunch - launch a process in a secured manner

## As a developer

- most long-term resident processes have two stages of life:
  - initialization
  - operation
- generally, more privileges are needed for initialization than operation
  - gain access to hardware, register as a resource manager, etc
  - a security-conscious program should drop unneeded privileges on that transition
    - usually done with `secpol_transition_type(NULL, NULI, 0)`
- for resource managers, should use `secpol_resmgr_attach()` instead of `resmgr_attach()`
  - allows control of ownership, permissions, etc from the security policy

## Part of a security policy might look like

``` text
type random_t;                            # define type for random at startup (initialization)

type random_t_run;                        # define type for random when running (operation)

allow random_t self:ability {             # give the random_t type some abilities
    prot_exec map_fixed                   # needed for process creation, loading shared libraries
    pathspace public_channel              # needed to become a resource manager
    srandom                               # get entropy from the kernel
    settypeid: random_t_run               # transition to the random_t_run type
    channel_connect: slogger_t            # connect to the system logger
};

allow_attach random_t {                   # allow random to register two pathnames
    /dev/random
    /dev/urandom
};

derive_type random_t run random_t__run;   # describe the default run transition for random

allow random_t__run self:ability {        # far reduced abilities for the run mode of random
    srandom
};
```
