use "../lib/describe.sml";
use "../lib/expect.sml";

suite (describe "describe"
    [should("return (\"describe\", _)", fn () =>
        expect (#1(describe "sut" [("description", "pass")])) toEqualStr "Ran 1 specs for sut:\n\n.\n\nFailures: 0\n===========\n\n"),

    should("return (_, \"pass\") when single spec passes", fn () =>
        expect (#2(describe "sut" [("description", "pass")])) toEqualStr "pass"),

    should("return (_, \"FAIL: a nested spec failed, see report above.\") when single spec fails", fn () =>
        expect (#2(describe "sut" [("description", "FAIL")])) toEqualStr "FAIL: a nested spec failed, see report above."),

    should("return (_, \"pass\") when no specs fail", fn () =>
        expect (#2(describe "sut" [("description", "pass"), ("another", "pass")])) toEqualStr "pass"),

    should("return (_, \"FAIL: a nested spec failed, see report above.\") when all specs fail", fn () =>
        expect (#2(describe "sut" [("description", "FAIL"), ("another", "FAIL")])) toEqualStr "FAIL: a nested spec failed, see report above."),

    should("return (_, \"FAIL: a nested spec failed, see report above.\") when one of many specs fail", fn () =>
        expect (#2(describe "sut" [("description", "pass"), ("another", "FAIL"), ("yet another", "pass")])) toEqualStr "FAIL: a nested spec failed, see report above."),

    should("return (_, \"pass\") when no spec in list", fn () =>
        expect (#2(describe "sut" [])) toEqualStr "pass"),

    should("propagate result from passing nested describe", fn () =>
        expect (#2(describe "sut" [(describe "sut" [])])) toEqualStr "pass")])
