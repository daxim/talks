use 5.024;
use strictures;
use Data::Dumper qw(Dumper);
use blib;
use hammer qw();

sub ruleA {
    hammer::action(
        hammer::choice(
            # hammer::epsilon_p,
            # epsilon should be at the start of the alternation,
            # not at the end!
            hammer::sequence(
                hammer::ch('x'),
                hammer::ch('z'),
            ),
            hammer::epsilon_p,
        ),
        sub { bless shift // [], 'flail::A' }
    )
}

sub ruleC {
    state $ruleC = hammer::indirect;
    hammer::bind_indirect(
        $ruleC,
        hammer::choice(
            hammer::sequence(
                $ruleC,
                hammer::ch('w')
            ),
            hammer::ch('v')
        )
    );
    return $ruleC;
}

sub ruleB {
    hammer::action(
        hammer::choice(
            hammer::sequence(
                ruleA,
                hammer::ch('x'),
                hammer::ch('y')
            ),
            ruleC
        ),
        sub { bless shift, 'flail::B' }
    )
}

sub TOP { ruleB }

say Dumper TOP->parse('xzxy');
say Dumper TOP->parse('vwwwwww');
