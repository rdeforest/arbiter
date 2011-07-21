use MooseX::Declare;

=pod

A dynamic operates under the rule of Constraints, taking input from a State
and generating output which will be combined into a new State.

=cut

class Arbiter::Dynamic {
    use YAML;

    has dir => (isa => 'Str', is => 'ro');

    method query(State $state) {
        my $changes = {};

        return $changes;
    }
}

