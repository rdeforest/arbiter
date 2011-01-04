use MooseX::Declare;

=pod

A Constraint defines or refines the terms of a 'game' which will be iterated
in a sandbox.

=cut

class Arbiter::Constraint {
    has dir => (isa => 'Str', is => 'ro');

    method add_to_world(Arbiter::Iterator $iterator) {
    }

    method new_state() {
        ...
    }

    method finish_state() {
        ...
    }
}


