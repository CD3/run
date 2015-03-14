A simple perl script that runs a set of commands.

run tries to run a set of commands using different handlers. For example, if you are working on
a cluster and the qsub command, run will create submission scripts and submit them to the scheduler.
If the qsub command does not exist, then other handlers are checked. For example, if the parallel command
exists (gnu parallel), it is used to run all commands in parallel.

If all other handlers fail, run will fallback to just running each command in serial, one after the other.
This turns out to still be useful, because if you have a set of simulations that you need to perform, you can
use run to automatically run each simulation after one has completed.

Current Handlers
qsub
gnuparallel
serial

Planned Handlers
xjobs

