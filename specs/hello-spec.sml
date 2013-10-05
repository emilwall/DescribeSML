use "../lib/describe.sml";
use "../lib/expect.sml";
use "../src/hello.sml";

suite (describe "hello"
    [should("say hello", fn () =>
        expect (hello "World") toEqualStr "Hello World!"),

     should("greet you", fn () =>
        expect (hello "You") toEqualStr "Hello You!")])
