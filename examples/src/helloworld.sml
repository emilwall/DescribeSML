(* Import DescribeSML *)
CM.make "../../describe.cm";
open Describe;
open Expect;

(* Define system under test *)
fun hello you = concat ["Hello ", you, "!"];

(* State expectations *)
suite (describe "hello" [
    should ("say Hello World! when given World as argument", fn () =>
        expect (hello "World")
            toEqualStr "Hello World!"),

    should ("always return string ending with exclamation mark", fn () =>
        expect (hello "")
            toMatch "!$")
])
