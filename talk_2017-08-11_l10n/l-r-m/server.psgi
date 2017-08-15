use 5.024;
use strictures;
use Encode qw(encode);
use Log::Report::Translator::POT qw();
use Log::Report
    qw(com.cantanea.simplecal),
    translator => Log::Report::Translator::POT->new(
        lexicon => 'share/locale',
#         charset => 'UTF-8',
    );
use Plack::Request qw();

my $app = sub {
    my ($env) = @_;
    my $req = Plack::Request->new($env);

    my $lang = $req->header('Accept-Language') // 'en';

    my $body = __('January')->toString($lang);
    sleep 1;
    $body .= __('February')->toString($lang);
    return [200, [], [encode 'UTF-8', $body]];
}
