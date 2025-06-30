create table "Zahlungseingang" (
    id        uuid        default gen_random_uuid() primary key,
    wann      timestamptz default now() not null,
    "Betrag"  numeric     check ("Betrag" > 0) not null,
    "Zahlung" "Zahlart"   not null
);

insert into "Zahlungseingang" ("Betrag", "Zahlung")
values
    (123.45, "Zahlart"("Bargeld"())),
    (234.45, "Zahlart"("Onlinezahlung"(
        "Anweiser" := 'pay@example.invalid'
    ))),
    (345.67, "Zahlart"("Zahlungskarte"(
        "Ausstellername" := 'M******',
        "PAN" := '0123456789',
        "Inhabername" := 'Foo Bar'
    )));
