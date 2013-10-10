use "../lib/describe.sml";
use "../lib/expect.sml";
use "../src/prime.sml";

suite(describe "Largest prime factor functions" [
describe "is_prime"
    [should("return true for 2", fn () =>
        expect (is_prime 2) toBe true)]
]);
