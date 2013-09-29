use "../lib/describe.sml";
use "../lib/expect.sml";
use "../src/factorial.sml";

val _ = describe "checked_factorial"
	[fn it => "should return 1 when n = 0",
     fn _ => expect (checked_factorial 0) toBeInt 1,

     fn it => "should raise Factorial when n < 0",
     fn _ => expect (fn _ => checked_factorial ~7) toThrow Factorial,

     fn it => "should be able to calculate factorial of 12",
     fn _ => expect (checked_factorial 12) toBeInt 479001600,

     fn it => "should raise Overflow when n > 12",
     fn _ => expect (fn _ => checked_factorial 100) toThrow Overflow]
