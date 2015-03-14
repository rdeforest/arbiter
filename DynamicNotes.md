# hook files #

## add-to-world ##

> `dynamics/$gen/add-to-world $name`

Called by bin/add when adding a dynamic to a world to give the dynamic
an opportunity to make note of its situation and raise objections if
it doesn't think it will know how to behave in a world.  Output is
saved as part of state 0.

## query ##

> `dynamics/$gen/query $name`

The output of this command is treated as YAML to be written to files under
`state/current/$name/`.

Besides taking its own name as input, it may use the contents of the state
directory as input.  Definitions may "send messages to" dynamic instances by
writing to the instance's current state before the state is generated.  For
example, in a game where agents are pitted against each other in some sort of
rotation, the definition responsible for determining the pairing could tell
each agent who its current partner is by emitting

> $agent: { opponent: $other\_agent }

Agents can query this by reading state/current/$self/opponent.

