CM.make "../../describe.cm";
open Describe;
open Expect;
use "../src/stopwatch.sml";

fun slow_fib n =
    if n < 3
    then 1
    else slow_fib(n - 2) + slow_fib(n - 1);

(* Timer dependent tests, will fail on some machines *)
suite (describe "Stopwatch.time" [
    should("return different time for different callbacks", fn () =>
        expect (Stopwatch.time (fn () => slow_fib 30))
            toNotEqualInt (Stopwatch.time (fn () => slow_fib 38))),

    should("take at least 1 000 microseconds to run slow_fib 30", fn () =>
        expect (Stopwatch.time (fn () => slow_fib 30)) toBeAtLeast 1000),

    should("take at most 10 000 microseconds to run slow_fib 30", fn () =>
        expect (Stopwatch.time (fn () => slow_fib 30)) toBeAtMost 10000)
])
