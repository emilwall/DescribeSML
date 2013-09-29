use "../lib/describe.sml";
use "../lib/expect.sml";
use "../src/robberlanguage.sml";

val _ = describe "RobberLanguage.isConsonant"
    [fn it => "should consider b to be a consonant",
     fn _ => expect (RobberLanguage.isConsonant #"b") toBe true,

     fn it => "should consider B to be a consonant",
     fn _ => expect (RobberLanguage.isConsonant #"B") toBe true,

     fn it => "should not consider a to be a consonant",
     fn _ => expect (RobberLanguage.isConsonant #"a") toBe false]

val _ = describe "RobberLanguage.translate"
    [fn it => "should repeat consonant with the letter o inserted in between",
     fn _ => expect (RobberLanguage.translate "s") toEqual "sos",

     fn it => "should not repeat vowels",
     fn _ => expect (RobberLanguage.translate "a") toEqual "a",

     fn it => "should work for long strings",
     fn _ => expect (RobberLanguage.translate "a long string") toEqual "a lolonongog sostotrorinongog",

     fn it => "should repeat capital consonants as lower case",
     fn _ => expect (RobberLanguage.translate "Astrid Lindgren") toEqual "Asostotroridod Lolinondodgogrorenon"]