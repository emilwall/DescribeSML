CM.make "../describe.cm";
open Describe;
open Expect;
use "../src/factorial.sml";

suite(describe "checked_factorial"
	[should("return 1 when n = 0", fn () =>
        expect (checked_factorial 0) toBeInt 1),

     should("raise Factorial when n < 0", fn () =>
        expect (fn _ => checked_factorial ~7) toThrow Factorial),

     should("be able to calculate factorial of 12", fn () =>
        expect (checked_factorial 12) toBeInt 479001600),

     should("raise Overflow when n > 12", fn () =>
        expect (fn _ => checked_factorial 100) toThrow Overflow)]);
