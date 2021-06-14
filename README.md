DescribeSML
===========

DescribeSML is a [BDD style](http://en.wikipedia.org/wiki/Behavior-driven_development)
testing framework for [Standard ML of New Jersey](http://www.smlnj.org/),
similar to [RSpec](http://rspec.info/)
and [Jasmine](http://jasmine.github.io/). [Example](example.sml):

```SML
(* Import DescribeSML *)
CM.make "describe.cm";
open Describe;
open Expect;

(* Define system under test *)
fun hello you = concat ["Hello ", you, "!"];

(* State expectations *)
suite (describe "hello" [
    should ("say Hello World! when given World as argument", fn () =>
        expect (hello "World")
            toEqualStr "Hello World!"),

    should ("always return string ending with exclamation mark", fn () =>
        expect (hello "")
            toMatch "!$")
])

(* Output:
Ran 2 specs for hello:

..

Total failures: 0
================= *)
```

This testing framework was developed as part of my thesis
[Rationales and Approaches for Automated Testing of JavaScript and Standard ML](https://github.com/emilwall/exjobb),
and not actively maintained. Feel free to add a pull request if you have made an improvement.

DescribeSML uses the SML/NJ Compilation and Library Manager (CM), so there is a lot of flexibility
regarding how to use it. [example-specs](example-specs) contains some example specs (tests)
of [simple functions](example-src), using DescribeSML.
They use relative references to the .cm file and calls open on the
exported structures, so that ```describe``` and ```should``` can be used instead of ```DescribeSML.describe```
and ```DescribeSML.should```.

DescribeSML consists of the **Describe** structure, which includes error reporting utilities and the
ability to have nested describes, and the **Expect** structure, which contains matchers such as ```toBe```,
```toEqualInt```, ```toContain```, ```toMatch``` and ```toThrow```. There are no dependencies between
the structures except that the **Describe** functions expect matchers to return a string beginning with
either "pass" or "FAIL". This means that you can use them seperately, replacing one of them with your
own implementation, if you feel like it.

Here is an example of how DescribeSML can be used (same as [here](example-specs/robberlanguage-spec.sml)):

```SML
CM.make "../describe.cm";
open Describe;
open Expect;
use "../example-src/robberlanguage.sml";

suite (describe "RobberLanguage" [
describe "isConsonant"
    [should("consider b to be a consonant", fn () =>
        expect (RobberLanguage.isConsonant #"b") toBe true),

     should("consider capital letters as consonants", fn () =>
        expect (RobberLanguage.isConsonant #"B") toBe true),

     should("not consider vowels as consonants", fn () =>
        expect (RobberLanguage.isConsonant #"a") toBe false)],

describe "translate"
    [should("repeat consonant with the letter o inserted in between", fn () =>
        expect (RobberLanguage.translate "s")
            toBeStr "sos"),

     should("not repeat vowels", fn () =>
        expect (RobberLanguage.translate "a")
            toHaveSize 1),

     should("work for long strings", fn () =>
        expect (RobberLanguage.translate "a long string")
            toMatch "lolonongog"),

     should("repeat capital consonants as lower case", fn () =>
        expect (RobberLanguage.translate "Astrid Lindgren")
            toEqualStr "Asostotroridod Lolinondodgogrorenon")]
])
```

If we have [this](example-src/robberlanguage.sml) (intentionally buggy) implementation:

```SML
structure RobberLanguage :>
sig
   val isConsonant : char -> bool
   val translate : string -> string
end =
struct
    val consonants = explode "cdfghjklmnpqrstvwxz"

    fun isConsonant c =
        List.exists (fn c' => c = c' orelse Char.toLower c = c') consonants

    fun process [] = []
      | process (c::cs) =
        if isConsonant c
        then (Char.toUpper c) :: #"o" :: c :: process cs
        else c :: process cs

    val translate = implode o process o explode
end
```

You get the following output from running the specs:

```
Ran 2 nested describes (total 7 specs) for RobberLanguage:

!!

Ran 3 specs for isConsonant:

!!.

should consider b to be a consonant: FAIL
should consider capital letters as consonants: FAIL

Ran 4 specs for translate:

!.!!

should repeat consonant with the letter o inserted in between: FAIL: expected "Sos" to equal "sos"
should work for long strings: FAIL: expected "a LoloNonGog SosTotRoriNonGog" to match "lolonongog"
should repeat capital consonants as lower case: FAIL: expected "ASosTotRoriDod LoLiNonDodGogRoreNon" to equal "Asostotroridod Lolinondodgogrorenon"

Total failures: 5
=================
```

This allows you to get detailed error reports for nested describes, with a wide
variety of matchers.

Fixing the bugs in the implementation:

```SML
val consonants = explode "bcdfghjklmnpqrstvwxz"
```

```SML
then c :: #"o" :: (Char.toLower c) :: process cs
```

yields

```
Ran 2 nested describes (total 7 specs) for RobberLanguage:

..

Total failures: 0
=================
```

If you have any questions, feedback or requests, please post an issue here on
github or email me at emilwall89 at gmail.com
