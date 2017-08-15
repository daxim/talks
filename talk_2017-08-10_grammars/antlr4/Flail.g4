grammar Flail;
B : A 'x' 'y' | C ;
A : /* epsilon */ | 'x' 'z' ;
C : C 'w' | 'v' ;
WS : [ \t\r\n]+ -> skip ; // skip spaces, tabs, newlines
