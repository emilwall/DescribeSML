CM.make "../describe.cm";
open Describe;
open Expect;
use "../src/spec-reporter.sml";
open SpecReporter;

suite (describe "spec-reporter" [
describe "report"
    [should("indicate failure with exclamation mark", fn () =>
        expect (report "" ("", "FAIL", 1)) toEqualStr "!"),

    should("indicate success with dot", fn () =>
        expect (report "" ("", "pass", 1)) toEqualStr "."),

    should("be able to print verbose result of success", fn () =>
        expect (report "verbose" ("description", "pass", 1))
            toEqualStr "should description: pass\n"),

    should("be able to print verbose result of failure", fn () =>
        expect (report "verbose" ("description", "FAIL", 1))
            toEqualStr "should description: FAIL\n"),

    should("omit \"should\" when description begins with \"Ran \"", fn () =>
        expect (report "verbose" ("Ran description", "FAIL", 1))
            toEqualStr "Ran description: FAIL\n")]
])
