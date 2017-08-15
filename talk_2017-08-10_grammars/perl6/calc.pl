use v6;
grammar Calculator {
    token TOP { [ <add> | <sub> ] }
    rule  add { <num> '+' <num> }
    rule  sub { <num> '-' <num> }
    token num { \d+ }
}
say Calculator.parse('2 + 3');
say Calculator.parse(Blob.new([50,32,43,32,51]));
