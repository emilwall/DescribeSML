(* Import DescribeSML *)
CM.autoload "../../describe.cm";
val suite = Describe.suite;
val describe = Describe.describe; 
val should = Describe.should;
val expect = Expect.expect;
val toEqualStr = Expect.toEqualStr;
val toMatch = Expect.toMatch;

(* Define system under test *)
fun hello you = "Hello " ^ you ^ "!";

(* State expectations *)
suite (describe "hello" [
    should ("return Hello World! when given World as argument", fn () =>
        expect (hello "World")
            toEqualStr "Hello World!"),

    should ("always return string ending with exclamation mark", fn () =>
        expect (hello "")
            toMatch "!$")
])
