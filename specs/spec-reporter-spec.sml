CM.make "../describe.cm";
open Describe;
open Expect;
use "../src/spec-reporter.sml";
open SpecReporter;

suite (describe "spec-reporter" [
describe "report"
    [should("indicate failure with exclamation mark", fn () =>
        expect (report "" ("", "FAIL", 1, 1)) toEqualStr "!"),

    should("indicate success with dot", fn () =>
        expect (report "" ("", "pass", 1, 0)) toEqualStr "."),

    should("be able to print verbose result of success", fn () =>
        expect (report "verbose" ("description", "pass", 1, 0))
            toEqualStr "should description: pass\n"),

    should("be able to print verbose result of failure", fn () =>
        expect (report "verbose" ("description", "FAIL", 1, 1))
            toEqualStr "should description: FAIL\n"),

    should("omit \"should\" when description begins with \"Ran \"", fn () =>
        expect (report "verbose" ("Ran description", "FAIL", 1, 1))
            toEqualStr "Ran description: FAIL\n"),

    should("omit \":\" when description begins with \"Ran \" " ^
           "and result is longer than 4 characters", fn () =>
        expect (report "verbose" ("Ran description\n", "FAIL: reason", 1, 1))
            toEqualStr "Ran description\nFAIL: reason\n"),

    should("not omit \":\" " ^
           "when description doesn't begin with \"Ran \" ", fn () =>
        expect (report "verbose" ("results", "FAIL: reason", 1, 1))
            toEqualStr "should results: FAIL: reason\n")]
])
