use "../lib/describe.sml";
use "../lib/expect.sml";
use "../src/robberlanguage.sml";

val _ = describe "RobberLanguage.isConsonant"
	[fn it => "should consider b to be a consonant",
	 fn _ => expect (RobberLanguage.isConsonant #"b") toBe true]

val _ = describe "RobberLanguage.translate"
	[fn it => "should repeat consonants with the letter o inserted in between",
	 fn _ => expect (RobberLanguage.translate "s") toEqual "sos"]