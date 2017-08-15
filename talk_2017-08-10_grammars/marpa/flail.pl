use 5.024;
use strictures;
use Data::Dumper qw(Dumper);
use Marpa::R2 qw();

my $grammar = Marpa::R2::Scanless::G->new({
    bless_package => 'flail',
    source        => \<<'',
:default ::= action => [values] bless => ::lhs
lexeme default = action => [ start, length, value ] bless => ::name latm => 1
:discard ~ whitespace
whitespace ~ [\s]+
:start ::= B
B ::= A 'x' 'y' | C
A ::= epsilon | 'x' 'z'
C ::= C 'w' | 'v'
epsilon ::=

});
# say $grammar->show_rules;

for my $input ('x z x y', 'v w w w w w w') {
    my $r = Marpa::R2::Scanless::R->new({
        grammar => $grammar,
#         trace_terminals => 1
    });
    $r->read(\$input);
    say Dumper $r->value;
}
