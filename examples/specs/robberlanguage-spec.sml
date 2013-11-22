CM.make "../../describe.cm";
open Describe;
open Expect;
use "../src/robberlanguage.sml";

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
