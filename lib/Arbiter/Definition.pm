use MooseX::Declare;

=pod

A Definition defines or refines the terms of a 'game' which will be iterated
in a sandbox.

=cut

class Arbiter::Definition {
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


