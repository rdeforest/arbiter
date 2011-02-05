use MooseX::Declare;

=pod

This object is responsible for combining a State, some Constraints and some
Generators to create a new State.

=cut

class Arbiter::Iterator {
    use Arbiter::State;

    has dir => (
            isa     => 'Str',
            is      => 'ro',
        );

    has constraints => (
            isa     => 'ArrayRef', 
            is      => 'rw', 
            lazy    => 1,
            builder => '_build_constraints',
            init_arg=> undef,
        );

    has generators => (
            isa     => 'ArrayRef', 
            is      => 'rw', 
            lazy    => 1,
            builder => '_build_generators',
            init_arg=> undef,
        );

    has state_num => (
            isa     => 'Num',
            is      => 'rw',
            default => 0,
        );

    method _build_constraints() {
        # Pull constraints from dir/constraints
        my $d = $self->dir;
        $self->{constraints} = [
                map { Constraint->new(dir => $_) } <$d/constraints/*>
            ];
    }

    method _build_generators() {
        # Pull generators from dir/generators
        my $d = $self->dir;
        $self->{generators} = [
                map { Constraint->new(dir => $_) } <$d/generators/*>
            ];
    }

    method create_next_state() {
        my $prev = $self->state_num;
        my $num  = $self->state_num($prev + 1);
        my $sdir = $self->dir . "/state/";

        mkdir "$sdir/$num";
        if (-e "$sdir/current") {
            rename "$sdir/current", "$sdir/previous";
            symlink "../$prev", "$sdir/$num";
        }
        symlink $num, "$sdir/current";
    }

    method apply_changes(Str $source, HashRef $changes) {
        # create the directory...
        for my $key (keys %{$changes->{$source}}) {
            my $value = $changes->{$source}{$key};
            # create the file...
            die "Not yet implemented.";
        }
    }

    method iterate() {
        my $next = $self->create_next_state;

        for my $c (@{$self->constraints}) {
            my $changes = $c->check_new_state($state);
            $next->apply_changes( pre => $changes );
        }

        for my $g (@{$self->generators}) {
            my $changes = $g->query;
            $next->apply_changes($g->id, $changes);
        }
        
        for my $c (@{$self->constraints}) {
            my $changes = $c->finish_state($next);
            $next->apply_changes( post => $changes );
        }
    }
}
