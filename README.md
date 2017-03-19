=head1 NAME

run - Quickly queue and run jobs from the command line.

=head1 DESCRIPTION

C<run> is a perl script that will run a set of commands.
It is primarily useful for running commands that are expected to run for a long
time, such as physics simulations.  C<run> uses "handlers" to actually run the
commands, and tries to automatically select the best handler to use to complete
the runs as quickly as possible. For example, if you are working on a cluster
and the C<qsub> command exists, C<run> will create submission scripts and submit
them to the scheduler.  If the C<qsub> command does not exist, then other handlers
are checked. For example, if the C<parallel> (gnu parallel) or C<xjobs> commands
are found, they can be used to run all commands in parallel.

If all other handlers fail, C<run> will fall back to just running each command
in serial, one after the other.  This turns out to still be useful, because if
you have a set of simulations that you need to perform, you can use C<run> to
automatically run each simulation after one has completed.

All handlers will first create a script wrapper for each command to run and
then run this script.  This is done so that extra information can be embedded
in the command output, such as a time stamp for timing data.


=head2 Current Handlers

=over

=item C<qsub>

This handler uses the C<qsub> command. C<qsub> is used to submit jobs to several HPC
schedulers including PBS, MOAB, and SGE. The qsub handler will automatically
create a submission script for each job and subit the scripts to the scheduler.
This is handy if you want to just quickly submit a basic job that does not
require a complex submission script.

=item C<gnuparallel>

This handler uses the C<parallel> command, from the gnuparallel project. C<parallel> is a
perl script that runs multiple jobs in parallel and even supports running jobs on remote computers
(not supported by run). It attempts to work as a parallel version of C<xargs>.

=item C<xjobs>

This handler uses the C<xjobs> command. C<xjobs> is a small C program written by Thomas Maier-Komer that
that a command multiple times with different arguments in parallel.
It strives to be a parallel version of xargs.

=item C<serial>

This handler just runs each job directly, one after the other.

=back

=head2 Possible Future Handlers

=over

=item C<pexec>

=back

Note that C<run> does not do load balancing. Each handler is given the list of commands to run, and they are responsible
for managing the system workload.

=head1 USAGE

  > run cmd1 [args] [: cmd2 [args] [...] ]

  if standard inputis piped in from another command, then run will read arguments from stdin and run each command with
  each argumnet.

  > command that produces list of arguents | run cmd1 [: cmd2 [...] ]
 

=head2 OPTIONS:

=over

=item C<-h> 

this help message.

=item C<-V LEVEL>

set verbose level to LEVEL.
  
=item C<-v>

enable verbose level 1.

=item C<-n>

dry run. don't execute handler commands, just print them to stdout.

=item C<-H HANDLER>

specify the HANDLER to use.

=item C<-O HANDLER_OPTIONS>

pass a list of options to the handler command.

=item C<-l>

list supported handlers.

=item C<-C CMD>

prepend CMD to all commands before running.

=item C<-d DEL>

use DEL to delimiter commands (default ':').

=item C<-w HH:MM:SS>

maximum walltime for jobs. this is only used for handlers that submit jobs to a scheduler.

=item C<-o>

send standard output to files. note that what happens here depends on the handler. some
handlers create a separate file for each command ran, some put all the stdout of all commands
in the same file, while others ignore this option all together and always space stdout in files.

=item C<-f>

leave the generated wrapper script in the current working directory.

=item C<-F>

treat all arguments as the names of already existing wrapper scripts and run directly without generating new wrapper scripts.

=back

=head1 EXAMPLES

run 3 scripts

    > run script1.sh : script2.sh : script3.sh

run 3 BTEC runs

    > run BTECthermal config1.btec : BTECthermal config2.btec : BTECthermal config3.btec

or, using the -C option

    > run -C BTECthermal config1.btec : config2.btec : config3.btec

or, using the stdin

    > echo config{1,2,3}.btec | run BTECthermal

run BTEC for all config files in the current directory

    > run -C BTECthermal -d' ' config*.btec

or, using the stdin

    > echo config*.btec | run BTECthermal

run 3 scripts using the gnuparallel handler

    > run -H gnuparallel script1.sh : script2.sh : script3.sh

first create run scripts for three commands, then run these scripts.

    > run -f cmd1 : cmd2 : cmd3
    > run -F run_script-*.sh

get a list of all handlers

    > run -l

=head1 INSTALLATION

C<run> is a single perl script. To install it, just place it somewhere in your PATH.

=head2 DEPENDENCIES

C<run> only uses a few standard Perl modules. These modules should be installed with Perl
and it should not be necessary to install any additional modules.

In addition to this, a few standard Linux commands are used.

=head1 LICENSE

The MIT License (MIT)

Copyright (c) 2015-present CD Clark III

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

