use MooseX::Declare;

=pod

A Constraint defines or refines the terms of a 'game' which will be iterated
in a sandbox.

=cut

class Constraint {
    has dir => (isa => 'Str', is => 'ro');

    method add_to_world(Iterator $iterator) {
    }

    method new_state() {
        ...
    }

    method finish_state() {
        ...
    }
}


