use "../lib/describe.sml";
use "../lib/expect.sml";
use "../src/fib.sml";

suite(describe "fib"
	[should("return empty list when limit = 0", fn () =>
        expect (fib 0) toBe []),

    should("return list with 1 when limit = 1", fn () =>
        expect (fib 1) toBe [1]),

    should("return list with to ones when limit = 2", fn () =>
        expect (fib 2) toBe [1, 1])]);
