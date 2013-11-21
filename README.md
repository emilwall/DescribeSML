DescribeSML
===========

DescribeSML is a [BDD style](http://en.wikipedia.org/wiki/Behavior-driven_development)
testing framework for [Standard ML of New Jersey](http://www.smlnj.org/),
similar to [RSpec](http://rspec.info/)
and [Jasmine](http://pivotal.github.io/jasmine/).

It is a work in progress, developed as part of my thesis
[Rationales and Approaches for Automated Testing of JavaScript and Standard ML](https://github.com/emilwall/exjobb),
which is also a work in progress.

DescribeSML uses the SML/NJ Compilation and Library Manager (CM), so there is a lot of flexibility
regarding how to use it. The **examples** directory contains some simple functions and specs (tests)
of them that use DescribeSML. They use relative references to the .cm file and calls open on the
exported structures, so that ```describe``` and ```should``` can be used instead of ```DescribeSML.describe```
and ```DescribeSML.should```.

DescribeSML consists of the **Describe** structure, which includes error reporting utilities and the
ability to have nested describes, and the **Expect** structure, which contains matchers such as ```toBe```,
```toEqualInt```, ```toContain```, ```toMatch``` and ```toThrow```. There are no dependencies between
the structures except that the **Describe** functions expect matchers to return a string beginning with
either "pass" or "FAIL". This means that you can use them seperately, replacing one of them with your
own implementation, if you feel like it.

Here is an example of how DescribeSML can be used:

```SML
CM.make "../../describe.cm";
open Describe;
open Expect;
use "../src/robberlanguage.sml";

suite (describe "RobberLanguage" [
    describe "isConsonant"
        [should("consider b to be a consonant", fn () =>
            expect (RobberLanguage.isConsonant #"b") toBe true),
    
         should("consider B to be a consonant", fn () =>
            expect (RobberLanguage.isConsonant #"B") toBe true),
    
         should("not consider a to be a consonant", fn () =>
            expect (RobberLanguage.isConsonant #"a") toBe false)],
    
    describe "translate"
        [should("repeat consonant with the letter o inserted in between", fn () =>
            expect (RobberLanguage.translate "s") toEqualStr "sos"),
    
         should("not repeat vowels", fn () =>
            expect (RobberLanguage.translate "a") toEqualStr "a"),
    
         should("work for long strings", fn () =>
            expect (RobberLanguage.translate "a long string") toEqualStr "a lolonongog sostotrorinongog"),
    
         should("repeat capital consonants as lower case", fn () =>
            expect (RobberLanguage.translate "Astrid Lindgren") toEqualStr "Asostotroridod Lolinondodgogrorenon")]
])
```

If we have this (intentionally buggy) implementation:

```SML
structure RobberLanguage =
struct
    fun isConsonant c =
        let
            val consonants = explode "cdfghjklmnpqrstvwxz"
        in
            List.exists (fn c' => c = c' orelse (Char.toLower c) = c') consonants
        end

    fun translate s =
    let
        fun process [] acc =
            rev acc
          | process (c::cs) acc =
            process cs (if isConsonant c then
                            (Char.toUpper c) :: #"o" :: c :: acc
                        else
                            c :: acc)

    in
        implode(process (explode s) [])
    end
end
```

You get the following output from running the specs:

```
Ran 2 nested describes (total 7 specs) for RobberLanguage:

!!

Ran 3 specs for isConsonant:

!!.

should consider b to be a consonant: FAIL
should consider B to be a consonant: FAIL

Ran 4 specs for translate:

!.!!

should repeat consonant with the letter o inserted in between: FAIL: expected "soS" to equal "sos"
should work for long strings: FAIL: expected "a loLonoNgoG soStoTroRinoNgoG" to equal "a lolonongog sostotrorinongog"
should repeat capital consonants as lower case: FAIL: expected "AsoStoTroRidoD LoLinoNdoDgoGroRenoN" to equal "Asostotroridod Lolinondodgogrorenon"

Total failures: 5
=================
```

This allows you to get detailed error reports for nested describes, with a wide
variety of matchers.

A more detailed description of how to use DescribeSML will follow.

If you have any questions, feedback or requests, please post an issue here on
github or email me at emil.wall at valtech.se
