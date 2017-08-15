use 5.024;
use strictures;
use Locale::TextDomain qw(com.cantanea.simplecal), 'share/locale';
use Locale::Util qw(parse_http_accept_language);
use Plack::Request qw();

use Locale::Messages qw();
Locale::Messages::select_package('gettext_dumb');

my $app = sub {
    my ($env) = @_;
    my $req = Plack::Request->new($env);
    $ENV{LANG} = (parse_http_accept_language $req->header('Accept-Language'))[0];
    my $body = __('January');
    sleep 1;
    $body .= __('February');
    return [200, [], [$body]];
}
