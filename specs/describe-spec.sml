CM.make "../describe.cm";
open Describe;
open Expect;

suite (describe "describe" [
describe "describe function"
    [should("return (\"describe\", _)", fn () =>
        expect (#1(describe "sut" [("desc", "pass")]))
            toEqualStr (concat ["Ran 1 specs for sut:\n\n.",
                                "\n\nFailures: 0\n===========\n\n"])),

    should("return (_, \"pass\") when single spec passes", fn () =>
        expect (#2(describe "sut" [("desc", "pass")]))
            toEqualStr "pass"),

    should("return (_, \"FAIL: a nested spec failed, see report above.\") " ^
           "when single spec fails", fn () =>
        expect (#2(describe "sut" [("desc", "FAIL")]))
            toEqualStr "FAIL: a nested spec failed, see report above."),

    should("return (_, \"pass\") when no specs fail", fn () =>
        expect (#2(describe "sut" [("desc", "pass"), ("another", "pass")]))
            toEqualStr "pass"),

    should("return (_, \"FAIL: a nested spec failed, see report above.\") " ^
           "when all specs fail", fn () =>
        expect (#2(describe "sut" [("desc", "FAIL"), ("another", "FAIL")]))
            toEqualStr "FAIL: a nested spec failed, see report above."),

    should("return (_, \"FAIL: a nested spec failed, see report above.\") " ^
           "when one of many specs fail", fn () =>
        expect (#2(describe "sut" [("desc", "pass"),
                                   ("another", "FAIL"),
                                   ("yet another", "pass")]))
            toEqualStr "FAIL: a nested spec failed, see report above."),

    should("return (_, \"pass\") when no spec in list", fn () =>
        expect (#2(describe "sut" [])) toEqualStr "pass"),

    should("propagate result from passing nested describe", fn () =>
        expect (#2(describe "sut" [(describe "sut" [])])) toEqualStr "pass")],

describe "should"
    [should("return description at first position", fn () =>
        expect (#1(should("description", fn _ => "pass")))
            toEqualStr "description"),

    should("return result at second position", fn () =>
        expect (#2(should("description", fn _ => "pass")))
            toEqualStr "pass")]
])
