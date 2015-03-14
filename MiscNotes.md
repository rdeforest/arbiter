Most of this is moving into OnDiskProtocol.  The rest will go
elsewhere at some point?

# contents of data directory #

  * defintions - library of definitions used in various worlds
  * dynamics - library of dynamics used in various worlds
  * worlds - the various worlds

# contents of world directories #

  * definitions
    * `$id-$name -> ../../definitions/$def`
      * `add-to-world    - ` exit 0 if this definition is happy joining a world
      * `add-definition  - ` exit 0 if this definition approves a later addition
      * `add-dynamic     - ` same, but for dynamics
      * `start-iteration - ` optionally perform world prep, validation, etc
        * An example usage would be implementation of a rule which says "assign pairs of players...".  This definition would add variables to the new state representing these pairings.  The agents would "know" to look for their opponents by agreement with the rules they are playing under.
      * `end-iteration   - ` validate a new state for finalization
        * A chance for a definition to detect and note rules violations at the state level.

  * dynamics
    * `$id-$name -> ../dynamics/$dyn`
      * `add-to-world    - ` same function as definition version
        * The other hooks don't exist for dynamics.  They cannot object to the addition of new dynamics and definitions cannot be added after dynamics.  Enforcing dependencies is the job of the definitions.
      * `query`
        * iteration hook

  * `state` - see OnDiskProtocol

  * `log` - again, see OnDiskProtocol

As long as no definitions identify conflicts between the changes requested by the agents, the runner script will flattened the data into `states/$state_num/`.

# interfaces of definition and dynamic scripts #

Scripts pull data from the state directory.  Scripts request changes by emitting YAML describing those changes.  The YAML data must be a flat hash of string:string pairs.  `$value` will be written to `$state/$source/$key`.  For dynamic output, $source is the identifier of the dynamic in question.  For definition output generated in state setup the source is hard-coded to "pre".  For definition output at the end of state processing the source is hard-coded to "post".

States are numbered in decimal starting from 0.

`$definition/add-*` are scripts which take a parameter naming the entity to be added.  Their output, if any, is state information.

State 0 is a special case.