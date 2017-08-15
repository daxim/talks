use 5.024;
use strictures;
use Locale::TextDomain::OO qw();
use Locale::TextDomain::OO::Lexicon::File::PO qw();
use Locale::TextDomain::OO::FunctionalInterface qw($loc_ref __ __nx);

$$loc_ref = Locale::TextDomain::OO->new(
    language => 'ru',
    domain   => 'com.cantanea.simplecal',
    category => 'LC_MESSAGES',
    plugins  => [qw(Expand::Gettext)], # ::DomainAndCategory
);
Locale::TextDomain::OO::Lexicon::File::PO->new->lexicon_ref({
    data => ['*:LC_MESSAGES:com.cantanea.simplecal' => '*/LC_MESSAGES/com.cantanea.simplecal.po',],
    decode => 1,
    search_dirs => ['./share/locale'],
});

say __('January');
