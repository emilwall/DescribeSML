use "describe.sml";
use "expect.sml";

fun hello you =
    concat ["Hello ", you, "!"]

val _ = describe "hello"
    [fn it => "should say hello",
     fn _ => expect (hello "World") toEqual("Hello World!"),

     fn it => "should greet you",
     fn _ => expect (hello "You") toEqual("Hello You!")]