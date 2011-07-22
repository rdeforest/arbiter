use MooseX::Declare;

=pod

This object is responsible for combining a State, some Definitions and some
Dynamics to create a new State.

=cut

class Arbiter::Iterator {
    use Arbiter::State;

    has dir => (
            isa     => 'Str',
            is      => 'ro',
        );

    has definitions => (
            isa     => 'ArrayRef', 
            is      => 'rw', 
            lazy    => 1,
            builder => '_build_definitions',
            init_arg=> undef,
        );

    has dynamics => (
            isa     => 'ArrayRef', 
            is      => 'rw', 
            lazy    => 1,
            builder => '_build_dynamics',
            init_arg=> undef,
        );

    has state_num => (
            isa     => 'Num',
            is      => 'rw',
            default => 0,
        );

    method _build_definitions() {
        # Pull definitions from dir/definitions
        my $d = $self->dir;
        $self->{definitions} = [
                map { Arbiter::Definition->new(dir => $_) } sort <$d/definitions/*>
            ];
    }

    method _build_dynamics() {
        # Pull dynamics from dir/dynamics
        my $d = $self->dir;
        $self->{dynamics} = [
                map { Arbiter::Dynamic->new(dir => $_) } <$d/dynamics/*>
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

        for my $c (@{$self->definitions}) {
            my $changes = $c->check_new_state($state);
            $next->apply_changes( pre => $changes );
        }

        for my $g (@{$self->dynamics}) {
            my $changes = $g->query;
            $next->apply_changes($g->id, $changes);
        }
        
        for my $c (@{$self->definitions}) {
            my $changes = $c->finish_state($next);
            $next->apply_changes( post => $changes );
        }
    }
}
