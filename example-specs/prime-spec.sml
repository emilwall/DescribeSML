CM.make "../describe.cm";
open Describe;
open Expect;
use "../example-src/prime.sml";

suite(describe "Largest prime factor functions" [
describe "is_prime"
    [should("return true for 2", fn () =>
        expect (is_prime 2) toBe true),

    should("return true for 3", fn () =>
        expect (is_prime 3) toBe true),

    should("return false for 4", fn () =>
        expect (is_prime 4) toBe false)]
]);
