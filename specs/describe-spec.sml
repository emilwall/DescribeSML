CM.make "../describe.cm";
open Describe;
open Expect;

suite (describe "describe" [
describe "describe function"
    [should("return (\"describe\", _, _)", fn () =>
        expect (#1(describe "sut" [("desc", "pass", 1)]))
            toEqualStr (concat ["Ran 1 specs for sut:\n\n.",
                                "\n\nFailures (sut): 0\n===========\n\n"])),

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

    should("return (_, \"FAIL: nested specs failed, see report above.\", _) " ^
           "when multiple specs fail", fn () =>
        expect (#2(describe "sut" [("desc", "FAIL", 1),
                                   ("another", "FAIL", 1)]))
            toEqualStr "FAIL: nested specs failed, see report above."),

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
            toEqualInt 1),

    should("return number of specs when single describe", fn () =>
        expect (#3(describe "sut" [("desc", "pass", 1),
                                   ("desc", "pass", 1)]))
            toEqualInt 2),

    should("indicate number of specs in description " ^
           "when single describe", fn () =>
        expect (#1(describe "sut" [("desc", "pass", 1),
                                   ("desc", "pass", 1)]))
            toMatch "Ran 2 specs"),

    should("indicate number of nested describes in description " ^
           "when nested describes", fn () =>
        expect (#1(describe "sut" [describe "sut2" [],
                                   describe "sut3" []]))
            toMatch "Ran 2 nested describes"),

    should("indicate total number of specs in description " ^
           "when nested describes", fn () =>
        expect (#1(describe "sut" [describe "sut2" [],
                                   describe "sut3" []]))
            toMatch "(total 0 specs)"),

    should("count single-spec describe as spec", fn () =>
        expect (#1(describe "sut" [describe "sut2" [("","pass",1)],
                                   describe "sut3" [("","pass",1)]]))
            toMatch "Ran 2 specs"),

    should("classify describes/specs individually", fn () =>
        expect (#1(describe "sut" [describe "sut2" [("","pass",1),
                                                    ("","pass",1)],
                                   describe "sut3" []]))
            toMatch "(total 2 specs)"),

    should("specify name of sut when displaying number of failures", fn () =>
        expect (#1(describe "sut" [("desc", "FAIL", 1),
                                   ("desc", "pass", 1)]))
            toMatch "Failures \\(sut\\): 1")],

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
