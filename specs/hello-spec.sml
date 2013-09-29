use "../lib/describe.sml";
use "../lib/expect.sml";
use "../src/hello.sml";

val _ = describe "hello"
    [fn it => "should say hello",
     fn _ => expect (hello "World") toEqualStr "Hello World!",

     fn it => "should greet you",
     fn _ => expect (hello "You") toEqualStr "Hello You!"]
