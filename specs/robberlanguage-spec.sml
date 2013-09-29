use "../lib/describe.sml";
use "../lib/expect.sml";
use "../src/robberlanguage.sml";

val _ = describe "RobberLanguage"
	[fn it => "should repeat consonants with the letter o inserted in between",
	 fn _ => expect (RobberLanguage "s") toEqual "sos"]