use "../lib/describe.sml";
use "../lib/expect.sml";
use "../src/fib.sml";

suite(describe "fib"
	[should("return empty list when limit = 0", fn () =>
        expect (fib 0) toBe [])]);
