use 5.024;
use Data::Dumper qw(Dumper);
use Pegex::Parser qw();
use Pegex::Grammar qw();
use Pegex::Tree::Wrap qw();

# package MyTree;
# use parent 'Pegex::Tree::Wrap';
# sub gotrule {
# use Data::Dump::Streamer    ; die Dump \@_;
# }

package main;
my $grammar = Pegex::Grammar->new(text => <<'');
B: A 'x' 'y' | C
A: '' | 'x' 'z'
C: C 'w' | 'v'

for my $input ('x z x y') {
    my $parser = Pegex::Parser->new(
        grammar => $grammar,
        receiver => Pegex::Tree::Wrap->new,
        debug => 1,
        recursion_limit => 100,
    );
    eval {
        say Dumper $parser->parse($input);
    } or say $@;
}
