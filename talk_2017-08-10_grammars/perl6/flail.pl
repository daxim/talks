use v6;
grammar Flail {
    rule TOP { <B> }
    rule B { <A> 'x' 'y' | <C> }
    rule A { '' | 'x' 'z' }
    rule C { <C> 'w' | 'v' }
}
Flail.parse('x z x y').say;
Flail.parse('v w w w w w w').say;
