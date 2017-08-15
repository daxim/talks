use 5.024;
use strictures;
use Locale::TextDomain qw(com.cantanea.simplecal), 'share/locale';
use Locale::Util qw(web_set_locale);
use Plack::Request qw();

my $app = sub {
    my ($env) = @_;
    my $req = Plack::Request->new($env);
    web_set_locale $req->header('Accept-Language');
    my $body = __('January');
    sleep 1;
    $body .= __('February');
    return [200, [], [$body]];
}
