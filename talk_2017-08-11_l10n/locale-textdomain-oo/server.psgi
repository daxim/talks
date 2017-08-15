use 5.024;
use strictures;
use Encode qw(encode);
use Locale::TextDomain::OO qw();
use Locale::TextDomain::OO::Lexicon::File::PO qw();
use Locale::TextDomain::OO::FunctionalInterface qw($loc_ref __ __nx);
use Plack::Request qw();

my $app = sub {
    my ($env) = @_;
    my $req = Plack::Request->new($env);

    $$loc_ref = Locale::TextDomain::OO->new(
        language => $req->header('Accept-Language') // 'en',
        domain   => 'com.cantanea.simplecal',
        category => 'LC_MESSAGES',
        plugins  => [qw(Expand::Gettext)],
    );
    Locale::TextDomain::OO::Lexicon::File::PO->new->lexicon_ref({
        data => ['*:LC_MESSAGES:com.cantanea.simplecal' => '*/LC_MESSAGES/com.cantanea.simplecal.po',],
        decode => 1,
        search_dirs => ['./share/locale'],
    });

    my $body = __('January');
    sleep 1;
    $body .= __('February');
    return [200, [], [encode 'UTF-8', $body]];
}
