use 5.040;
package typedemo {
    use strictures;
    use Type::Library -base;
    use Types::Standard qw(Dict StrMatch Str);
    use Type::Utils qw(as declare enum where);

    enum Bargeld => [''];
    declare RFC5322AddrSpec => as StrMatch[qr'^[\w+-]+(?:\.[\w+-]+)*@[\da-z]+(?:[.-][\da-z]+)*\.[a-z]{2,}$'];
    declare Onlinezahlung => as Dict[Anweiser => RFC5322AddrSpec()];
    enum Aussteller => [qw(M****** V***)];
    declare ISO7812 => as Str, where { 10 <= length($_) and length($_) <= 19 };
    declare Inhaber => as Str, where { length($_) > 0 };
    declare Zahlungskarte => as Dict[ Ausstellername => Aussteller(), PAN => ISO7812(), Inhabername => Inhaber() ];
    declare Zahlart => as Bargeld() | Onlinezahlung() | Zahlungskarte();
}
