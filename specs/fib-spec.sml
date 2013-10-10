CM.make "../describe.cm";
open Describe;
open Expect;
use "../src/fib.sml";

suite(describe "fibonacci functions" [
describe "fib"
    [should("return empty list when limit = 0", fn () =>
        expect (fib 0) toBe []),

    should("return list with ones when limit = 1", fn () =>
        expect (fib 1) toBe [1, 1]),

    should("return list with two ones and a two when limit = 2", fn () =>
        expect (fib 2) toBe [1, 1, 2]),

    should("return list with fibonacci numbers not greater than limit", fn () =>
        expect (fib 13) toBe [1, 1, 2, 3, 5, 8, 13])],

describe "even_fib"
    [should("return empty list when limit = 0", fn () =>
        expect (even_fib 0) toBe []),

    should("return empty when limit = 1", fn () =>
        expect (even_fib 1) toBe []),

    should("return list with a two when limit = 2", fn () =>
        expect (even_fib 2) toBe [2]),

    should("return list with even fibonacci numbers not greater than limit", fn () =>
        expect (even_fib 13) toBe [2, 8])]
]);
