use MooseX::Declare;

=pod

A generator operates under the rule of Constraints, taking input from a State
and generating output which will be combined into a new State.

=cut

class Arbiter::Generator {
    use YAML;

    has dir => (isa => 'Str', is => 'ro');

    method query(State $state) {
        my $changes = {};

        return $changes;
    }
}

