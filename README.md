# run
A simple perl script that runs a set of commands.

-----

`run` tries to run a set of commands using different handlers. It is primarily useful for running commands
that are expected to run for a long time, such as physics simulations, and it attempts to find a handler
that will complete all commands as quicly as possible. For example, if you are working on
a cluster and the qsub command exists, `run` will create submission scripts and submit them to the scheduler.
If the qsub command does not exist, then other handlers are checked. For example, if the parallel command
exists (gnu parallel), it is used to run all commands in parallel.

If all other handlers fail, `run` will fallback to just running each command in serial, one after the other.
This turns out to still be useful, because if you have a set of simulations that you need to perform, you can
use `run` to automatically run each simulation after one has completed.

Current Handlers
 - qsub
 - gnuparallel
 - serial

Planned Handlers
 - xjobs
 - pexec

Note that `run` does not doe load ballancing. Each handler is given the list of commands to run, and they are responsible
for managing the system workload.
