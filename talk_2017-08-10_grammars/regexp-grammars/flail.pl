use 5.024;
use Data::Dumper qw(Dumper);
use Regexp::Grammars;

my $parser = qr{
    <logfile: - >
    <debug: run>
    <B>
    <rule: B> <A> x y | <C>
    <rule: A> | x z
    <rule: C> <C> w | v
}msx;

for my $input ('x z x y', 'v w w w w') {
    if ($input =~ $parser) {
        say Dumper \%/;
    }
}
