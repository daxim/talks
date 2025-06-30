create schema "Demo";
set search_path = "Demo";

create type "Bargeld" as /*unit*/ enum('');
create function "Bargeld"()
    returns "Bargeld"
    language sql
    return ''::"Bargeld";

create domain "RFC5322AddrSpec" as text
    check (value ~ '^[\w+-]+(?:\.[\w+-]+)*@[\da-z]+(?:[.-][\da-z]+)*\.[a-z]{2,}$');
create type "Onlinezahlung" as /*record*/(
    "Anweiser" "RFC5322AddrSpec"
);
create function "Onlinezahlung"(
    "Anweiser" "RFC5322AddrSpec"
)
    returns "Onlinezahlung"
    language sql
    return row("Anweiser");

create type "Aussteller" as enum('M******', 'V***');
create domain "ISO7812" as text
    check (10 <= length(value) and length(value) <= 19);
create domain "Inhaber" as text
    check (length(value) > 0);
create type "Zahlungskarte" as /*record*/(
    "Ausstellername" "Aussteller",
    "PAN" "ISO7812",
    "Inhabername" "Inhaber"
);
create function "Zahlungskarte"(
    "Ausstellername" "Aussteller",
    "PAN" "ISO7812",
    "Inhabername" "Inhaber"
)
    returns "Zahlungskarte"
    language sql
    return row("Ausstellername", "PAN", "Inhabername");

create type "Zahlart_T" as /*union*/(
    "Bar" "Bargeld",
    "Online" "Onlinezahlung",
    "Karte" "Zahlungskarte"
);
create domain "Zahlart" as "Zahlart_T"
    check (
        (
            (value)."Bar" is not null and
            (value)."Online" is null and
            (value)."Karte" is null
        ) or 
        (
            (value)."Bar" is null and
            (value)."Online" is not null and
            (value)."Karte" is null
        ) or 
        (
            (value)."Bar" is null and
            (value)."Online" is null and
            (value)."Karte" is not null
        )
    );
create function "Zahlart"("Bar" "Bargeld")
    returns "Zahlart"
    language sql
    return row("Bar", null, null);
create function "Zahlart"("Online" "Onlinezahlung")
    returns "Zahlart"
    language sql
    return row(null, "Online", null);
create function "Zahlart"("Karte" "Zahlungskarte")
    returns "Zahlart"
    language sql
    return row(null, null, "Karte");
create function "~Zahlart"("Zahlung" "Zahlart")
    returns record
    language sql
    return case
        when ("Zahlung")."Bar" is not null then row(pg_typeof(("Zahlung")."Bar"), ("Zahlung")."Bar")
        when ("Zahlung")."Online" is not null then row(pg_typeof(("Zahlung")."Online"), ("Zahlung")."Online")
        when ("Zahlung")."Karte" is not null then row(pg_typeof(("Zahlung")."Karte"), ("Zahlung")."Karte")
    end;
