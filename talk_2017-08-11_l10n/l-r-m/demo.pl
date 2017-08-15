use 5.024;
use strictures;
use Log::Report::Translator::POT qw();
use Log::Report
    qw(com.cantanea.simplecal),
    translator => Log::Report::Translator::POT->new(
        lexicon => 'share/locale',
        charset => 'UTF-8',
    );

say __("January")->toString('nl');
