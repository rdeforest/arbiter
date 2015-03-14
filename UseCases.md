# Introduction #

This page is intended to be the beginnings of an actual specification.


# Details #

## Simplicity ##

It should not take more than a few minutes to create a simple
Definition or Dynamic.  For example, to create a "Cooperate until my
opponent defects, then always defect", the query script should just be
a few lines:

  * is current strategy is defect?
    * defect
    * exit
  * is opponent's previous move defect?
    * set strategy to defect
    * defect
    * exit
  * cooperate