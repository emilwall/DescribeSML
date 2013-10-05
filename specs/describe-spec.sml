use "../lib/describe.sml";
use "../lib/expect.sml";

val _ = describe "describe"
    [should("return (sut, \"pass\") when no specs fail", fn () =>
        expect (describe "sut" [("description", "pass")]) toEqual ("sut", "pass"))]
