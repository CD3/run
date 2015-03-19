# run
A simple perl script that runs a set of commands.

-----

#Description
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

Note that `run` does not do load ballancing. Each handler is given the list of commands to run, and they are responsible
for managing the system workload.


#Usage
Run a set of commands, using scheduler if possible.

USEAGE: run cmd1 [args] [: cmd2 [args] [...] ]

OPTIONS:

  -h            : this help message

  -V LEVEL      : set verbose level to LEVEL
  
  -v            : enable verbose level 1

  -n            : dry run. don't execute hanlder commands, just print them to stdout

  -H HANDLER    : specify the HANDLER to use

  -l            : list supported handlers

  -C CMD        : prepend CMD to all commands befor running

  -d DEL        : use DEL to delimite commands (default ':')

  -w HH:MM:SS   : maximum walltime for jobs. this is only used for handlers that submit jobs to a scheduler.

  -o            : send standard output to files. note that this is only meaningful for handlers that would normally send stdout to the screen.

  -f            : leave the generated wrapper script in the current working directory.

  -F            : treat all arguments as the names of already existing wrapper scripts and run dirrectly without generating new wrapper scripts.

All handlers will first create a script wrapper for each command to run and then run this script.
This is done so that extra information can be embedded in the command output, such as a timestamp for timing data.

EXAMPLES:

run 3 scripts

    > run script1.sh : script2.sh : script3.sh

run 3 BTEC runs

    > run -C BTECthermal config1.btec : config2.btec : config3.btec

run BTEC for all config file in the current directory

    > run -C BTECthermal -d' ' config*.btec

run 3 scripts using the gnuparallel handler

    > run -H gnuparallel script1.sh : script2.sh : script3.sh

get a list of all handlers

    > run -l

