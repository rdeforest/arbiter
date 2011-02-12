use Test::Simple tests => 8; 

use FindBin;
use lib "$FindBin::Bin/../lib";

use Arbiter::Dir;

my $original_data = {
    list   => [ qw(zero one two) ],
    string => "hello world",
};

Arbiter::Dir::writedata("dirtest", $original_data);

my $read_data = Arbiter::Dir::readdata("dirtest");

ok(defined($read_data), "read succeeded");

ok(ref($read_data) eq "HASH", "data came back as a hash");

ok($read_data->{string} eq $original_data->{string}, "wrote and read string");

ok(ref($read_data->{list}) eq "ARRAY", "got back a list");
my $old_list = $original_data->{list};
my $new_list = $read_data->{list};

ok($#$new_list == $#$old_list, "list came back same length");
ok($read_data->{list}[0] eq $original_data->{list}[0], "list element 0 matches");
ok($read_data->{list}[1] eq $original_data->{list}[1], "list element 1 matches");
ok($read_data->{list}[2] eq $original_data->{list}[2], "list element 2 matches");

system('rm -rf dirtest');
