CM.make "../describe.cm";
open Describe;
open Expect;

suite (describe "describe" [
describe "describe function"
    [should("return (\"describe\", _, _)", fn () =>
        expect (#1(describe "sut" [("desc", "pass", 1)]))
            toEqualStr (concat ["Ran 1 specs for sut:\n\n.",
                                "\n\nFailures: 0\n===========\n\n"])),

    should("return (_, \"pass\", _) when single spec passes", fn () =>
        expect (#2(describe "sut" [("desc", "pass", 1)]))
            toEqualStr "pass"),

    should("return (_, \"FAIL: a nested spec failed, see report above.\", _) " ^
           "when single spec fails", fn () =>
        expect (#2(describe "sut" [("desc", "FAIL", 1)]))
            toEqualStr "FAIL: a nested spec failed, see report above."),

    should("return (_, \"pass\") when no specs fail", fn () =>
        expect (#2(describe "sut" [("desc", "pass", 1),
                                   ("another", "pass", 1)]))
            toEqualStr "pass"),

    should("return (_, \"FAIL: a nested spec failed, see report above.\", _) " ^
           "when all specs fail", fn () =>
        expect (#2(describe "sut" [("desc", "FAIL", 1),
                                   ("another", "FAIL", 1)]))
            toEqualStr "FAIL: a nested spec failed, see report above."),

    should("return (_, \"FAIL: a nested spec failed, see report above.\", _) " ^
           "when one of many specs fail", fn () =>
        expect (#2(describe "sut" [("desc", "pass", 1),
                                   ("another", "FAIL", 1),
                                   ("yet another", "pass", 1)]))
            toEqualStr "FAIL: a nested spec failed, see report above."),

    should("return (_, \"pass\") when no spec in list, _", fn () =>
        expect (#2(describe "sut" [])) toEqualStr "pass"),

    should("propagate result from passing nested describe", fn () =>
        expect (#2(describe "sut" [(describe "sut" [])])) toEqualStr "pass"),

    should("return (_, _, numberOfSpecs)", fn () =>
        expect (#3(describe "sut" [("desc", "pass", 1)]))
            toEqualInt 1)],

describe "should"
    [should("return description at first position", fn () =>
        expect (#1(should("description", fn _ => "pass")))
            toEqualStr "description"),

    should("return result at second position", fn () =>
        expect (#2(should("description", fn _ => "pass")))
            toEqualStr "pass"),

    should("return number of specs at third position", fn () =>
        expect (#3(should("description", fn _ => "pass")))
            toEqualInt 1)]
])
