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
