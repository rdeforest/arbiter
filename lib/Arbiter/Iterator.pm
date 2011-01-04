use MooseX::Declare;

=pod

This object is responsible for combining a State, some Constraints and some
Generators to create a new State.

=cut

class Arbiter::Iterator {
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

    method iterate(State $state) {
        my $next = $self->create_next_state;

        for my $c (@{$self->constraints}) {
            my $changes = $c->check_new_state($state);
            $next->apply_changes($changes);
        }

        my @changes;
        for my $g (@{$self->generators}) {
            push @changes, @{$g->query};
        }
        $next->apply_changes([@changes]);
        
        for my $c (@{$self->constraints}) {
            $c->finish_state($next);
        }

        $self->add_state($next);
    }
}
