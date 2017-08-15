use 5.024;
use strictures;
use Time::HiRes qw(sleep);

my @lang = qw(ar nl);
for (1..100) {
    sleep rand;
    my $lang = $lang[rand @lang];
    system "http -b :5000 Accept-Language:$lang &";
}
