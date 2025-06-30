import * as v from 'valibot';

enum Bargeld_T { Bargeld_GENSYM0 = '' }
const Bargeld = v.enum(Bargeld_T);

const RFC5322AddrSpec = v.pipe(
    v.string(),
    v.regex(/^[\w+-]+(?:\.[\w+-]+)*@[\da-z]+(?:[.-][\da-z]+)*\.[a-z]{2,}$/)
);
type RFC5322AddrSpec_T = v.InferOutput<typeof RFC5322AddrSpec>;

const Onlinezahlung = v.object({
    Anweiser: RFC5322AddrSpec,
});
type Onlinezahlung_T = v.InferOutput<typeof Onlinezahlung>;

enum Aussteller_T { M = 'M******', V = 'V***' }
const Aussteller = v.enum(Aussteller_T);

const ISO7812 = v.pipe( v.string(), v.minLength(10), v.maxLength(19) );
type ISO7812_T = v.InferOutput<typeof ISO7812>;

const Inhaber = v.pipe(
    v.string(),
    v.minLength(1)
);
type Inhaber_T = v.InferOutput<typeof Inhaber>;

const Zahlungskarte = v.object({
    Ausstellername: Aussteller,
    PAN: ISO7812,
    Inhabername: Inhaber,
});
type Zahlungskarte_T = v.InferOutput<typeof Zahlungskarte>;

const Zahlart = v.union([Bargeld, Onlinezahlung, Zahlungskarte]);
type Zahlart_T = v.InferOutput<typeof Zahlart>;
