Der Datentyp und die Datenbank
==============================

2025-06-23

Lars Dɪᴇᴄᴋᴏᴡ

<mailto:larsd@mailbox.org>

<http://vienna.pm.org>

----

Vortrag beschäftigt sich mit Datentypen

Daten liegen in Datenbank, Datentypen auch

```sql
create table "Lagerstand" (
    "Id"        uuid   default gen_random_uuid() primary key,
    "Anzahl"    bigint check ("Anzahl" >= 0) default 0 not null,
    "Dingsbums" text   check (length("Dingsbums") > 0) not null
);
```

----

einfache Typen sind von Anfang an möglich

was ist mit komplexen Typen?

Programmiersprachen außerhalb der Datenbank

----

# zwei Arten komplexer Typen

## Produkttyp

realistisches Ding

    Typ "Ding" ⩴
        "Hersteller"   : text
      ∧ "Name"         : text
      ∧ "Seriennummer" : text

verknüpft mit **und**

```sql
create table "Lagerstand" (
    "Id"       uuid   default gen_random_uuid() primary key,
    "Anzahl"   bigint check ("Anzahl" >= 0) default 0 not null,
    "Dingbums" "Ding" not null
);
```

Publikum: wer kennt/weiß das?

----

## Produkttyp

    Typ "Ding" ⩴
        "Hersteller"   : text
      ∧ "Name"         : text
      ∧ "Seriennummer" : text

verknüpft mit **und**

SQL: Verbundtyp

```sql
create type "Ding" as (
    "Hersteller"   text,
    "Name"         text,
    "Seriennummer" text
);
```

----

## Summentyp

    Typ Entität ⩴
        "dieses"
      ∨ "jenes"
      ∨ "anderes"

verknüpft mit **oder**

kommen auch ziemlich häufig vor

----

# Beispiele für Summentyp

## fehlerträchtige Funktionen

    fn send_recv(req: NetworkRequest → NetworkError | ResponseBody): …

----

# Beispiele für Summentyp

## Parserergebnis

[CSS-Farben](https://developer.mozilla.org/docs/Web/CSS/color)

    CSS_Color ⩴
        CSS_Keyword # 'currentcolor'
      | CSS_Named   # 'red' | 'orange' | 'tan' | 'rebeccapurple' | …
      | CSS_Hex     # '#090' | '#009900' | '#090a' | '#009900aa'
      | CSS_RGB     # 'rgb(34, 12, 64)'
      | CSS_HSL     # 'hsl(30, 100%, 50%, 0.6)'
      | CSS_HWB     # 'hwb(90 10% 10%)'
      | CSS_Global  # 'inherit' | 'initial' | 'revert' | 'revert-layer' | 'unset'

----

auch diese Typen in DB nachbilden/modellieren

These: Summentyp ist irgendwie nicht vorgesehen 🙁

----

🗱 Problem: Typ in DB abschwächt

in der Programmiersprache außerhalb stark

⟿ die Programmiersprache reißt die Aufgabe der DB an sich

Zuständigkeit verstreut auf mehrere Systeme

mehr Aufwand durch Gleichschaltung und wiederholte Typprüfung

----

Spekulation, wie kam es zur Misere?

Schuld gebe ich Autoren des SQL-Standards

* kennen ihr Feld Informatik & Informationssysteme nicht
* Leidensdruck war nie ausreichend stark genug

----

aber: mit Bordmitteln kann man Summentypen nachbilden

Beispiel ist ein bisschen an den Haaren herbeizogen

will lieber die Merkmale vollständig zeigen, so dass es auf eine Seite passt

----

```
Typ Zahlart ⩴
    Bargeld: unit
  ∨
    Onlinezahlung: (
        RFC5322AddrSpec: text check (value ~ '………')
        -- z.B. 'pay@example.invalid'
    )
  ∨
    Zahlungskarte: (
        Aussteller: enum('M******', 'V***')
      ∧
        ISO7812: text check (10 <= …… <= 19)
        -- z.B. 1234567890
      ∧
        Inhaber: text check (…… > 0)
        -- z.B. 'Foo Bar'
    )
```

----

wenn DB zentraler Ort für Typen: wie komplexe Typen ausdrücken?

unter der Annahme, SQL-Grammatik sei erweiterbar

```sql
create type "Zahlart" as union (
    "Bar" unit as "Bargeld",
    "Online" record (
        "Anweiser" text check (value ~ '^[\w+-]+(?:\.[\w+-]+)*@[\da-z]+(?:[.-][\da-z]+)*\.[a-z]{2,}$') as "RFC5322AddrSpec"
    ) as "Onlinezahlung",
    "Karte" record (
        "Ausstellername" enum('M******', 'V***') as "Aussteller",
        "PAN" text check (10 <= length(value) and length(value) <= 19) as "ISO7812",
        "Inhabername" text check (length(value) > 0) as "Inhaber"
    ) as "Zahlungskarte"
);
```

----

leider ist das nicht direkt möglich

aber: Verbundtypen, Typen mit Einschränkungen (SQL-Domänen), Funktionen zur Synthese/Analyse

Beispiel → `typedemo.sql`

----

die Übersetzung kann automatisch geschehen

Compiler

* SQL
* https://standardschema.dev
* https://p3rl.org/Type::API

Beispiele → `typedemo.{pm,ts}` 

----

in der Benutzung → `demo2.sql`

![](Bildschirmfoto_20250623_163127.webp)

----

# Alternativen

dasselbe Ziel auch auf andere Weise:

* Missbrauch von Tabellen als Typ und exzessive Normalisierung
* Serialisierung nach Blob oder JSON

aufwändiger beim Übersetzen oder weniger typsicher bzw. sabotiert Indizierung

----

# Ausblick

## SQL ist schwachbrüstig

* Grammatik nicht erweiterbar
* Typen, Domänen sind keine Werte
* Einschränkungen sollen Teil des Typs sein
* Fehlermeldungen ungenau
* Reihenfolge beim Anlegen notwendig, keine Vorwärtsangabe

## Compiler

* `alter type …` usw. fehlt
* mehr Ausdrücke für Einschränkungen, oder ganze Funktionen
* mehr Ausgabeformate/-programmiersprachen

----

`__END__`

Fragen? Kommentare? Anregungen?
