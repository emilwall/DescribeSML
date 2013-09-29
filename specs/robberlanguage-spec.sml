use "../lib/describe.sml";
use "../lib/expect.sml";
use "../src/robberlanguage.sml";

val _ = describe "RobberLanguage.isConsonant"
	[fn it => "should consider b to be a consonant",
	 fn _ => expect (RobberLanguage.isConsonant #"b") toBe true]

val _ = describe "RobberLanguage.translate"
	[fn it => "should repeat consonant with the letter o inserted in between",
	 fn _ => expect (RobberLanguage.translate "s") toEqual "sos",

     fn it => "should not repeat vowels",
     fn _ => expect (RobberLanguage.translate "a") toEqual "a",

     fn it => "should work for long strings",
     fn _ => expect (RobberLanguage.translate "a long string") toEqual "a lolonongog sostotrorinongog"]