use "../lib/describe.sml";
use "../lib/expect.sml";

val _ = describe "describe"
    [should("return (sut, _) when no specs fail", fn () =>
        expect (#1(describe "sut" [("description", "pass")])) toEqualStr "sut"),

    should("return (_, \"pass\") when no specs fail", fn () =>
        expect (#2(describe "sut" [("description", "pass")])) toEqualStr "pass"),

    should("return (_, \"FAIL: a nested spec failed, see report above.\") when a spec fail", fn () =>
        expect (#2(describe "sut" [("description", "FAIL")])) toEqualStr "FAIL: a nested spec failed, see report above.")]
