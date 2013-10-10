CM.make "../describe.cm";
open Describe;
open Expect;
use "../src/hello.sml";

suite (describe "hello"
    [should("say hello", fn () =>
        expect (hello "World") toEqualStr "Hello World!"),

     should("greet you", fn () =>
        expect (hello "You") toEqualStr "Hello You!")])
