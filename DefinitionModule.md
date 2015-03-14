Definitions are the constraints within which [Dynamics](DynamicModule.md)
operate.  Definitions are concerned with the nature of the experiment
being performed while Dynamics represent the "variables" to be
compared in the experiment.

# Files #

The source for Definition modules is kept in `data/definitions` in
directories named after the Definitions.  Each world keeps its own
list of imported Definitions as a set of symlinks under its own
`definitions` directory.  The links are named with a leading
number used to represent the order of the definitions.

# Hooks #

All hooks are invoked with the current working directory set to the
root of the world directory.

## called by `bin/add` ##

### add-to-world ###

Invoked when the current definition is to be added to a world.

### add-definition name ###

Invoked to see if this Definition approves of the addition of another
Definition after it.  Takes the name of the added Definition as a
parameter.

### add-dynamic ###

Invoked to see if this Definition approves of the addition of a
Dynamic.

## start-iteration ##

Invoked in the [Setup phase](StatePhases.md).  Output is written directly
to the new state.

## end-iteration ##

Invoked in the [Finalization phase](StatePhases.md).  Output is written
directly to the new state.  Definition will likely consult the log and
current state to determine its output.