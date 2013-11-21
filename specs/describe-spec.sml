CM.make "../describe.cm";
open Describe;
open Expect;

suite (describe "describe" [
describe "describe function"
    [should("return (\"describe\", _, _, _)", fn () =>
        expect (#1(describe "sut" [("desc", "pass", 1, 0)]))
            toEqualStr "Ran 1 specs for sut:\n\n.\n\n"),

    should("return (_, \"\", _, _)", fn () =>
        expect (#2(describe "sut" [("desc", "pass", 1, 0)]))
            toEqualStr ""),

    should("return (_, _, numberOfSpecs, _)", fn () =>
        expect (#3(describe "sut" [("desc", "pass", 1, 0)]))
            toEqualInt 1),

    should("return number of specs when single describe", fn () =>
        expect (#3(describe "sut" [("desc", "pass", 1, 0),
                                   ("desc", "pass", 1, 0)]))
            toEqualInt 2),

    should("indicate number of specs in description " ^
           "when single describe", fn () =>
        expect (#1(describe "sut" [("desc", "pass", 1, 0),
                                   ("desc", "pass", 1, 0)]))
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
        expect (#1(describe "sut" [describe "sut2" [("", "pass", 1, 0)],
                                   describe "sut3" [("", "pass", 1, 0)]]))
            toMatch "Ran 2 specs"),

    should("classify describes/specs individually", fn () =>
        expect (#1(describe "sut" [describe "sut2" [("", "pass", 1, 0),
                                                    ("", "pass", 1, 0)],
                                   describe "sut3" []]))
            toMatch "(total 2 specs)"),

    should("return (_, _, _, 0) when single spec passes", fn () =>
        expect (#4(describe "sut" [("desc", "pass", 1, 0)]))
            toBeInt 0),

    should("return (_, _, _, 1) " ^
           "when single spec fails", fn () =>
        expect (#4(describe "sut" [("desc", "FAIL", 1, 1)]))
            toBeInt 1),

    should("return (_, _, _, 0) when no specs fail", fn () =>
        expect (#4(describe "sut" [("desc", "pass", 1, 0),
                                   ("another", "pass", 1, 0)]))
            toBeInt 0),

    should("return (_, _, _, 2) " ^
           "when multiple specs fail", fn () =>
        expect (#4(describe "sut" [("desc", "FAIL", 1, 1),
                                   ("another", "FAIL", 1, 1)]))
            toBeInt 2),

    should("return (_, _, _, 1) " ^
           "when one of many specs fail", fn () =>
        expect (#4(describe "sut" [("desc", "pass", 1, 0),
                                   ("another", "FAIL", 1, 1),
                                   ("yet another", "pass", 1, 0)]))
            toBeInt 1),

    should("return (_, _, _, 0) when no spec in list", fn () =>
        expect (#4(describe "sut" [])) toBeInt 0),

    should("propagate result from passing nested describe", fn () =>
        expect (#4(describe "sut" [(describe "sut" [])])) toBeInt 0)],

describe "should"
    [should("return description at first position", fn () =>
        expect (#1(should("description", fn _ => "pass")))
            toEqualStr "description"),

    should("return result at second position", fn () =>
        expect (#2(should("description", fn _ => "pass")))
            toEqualStr "pass"),

    should("return number of specs at third position", fn () =>
        expect (#3(should("description", fn _ => "pass")))
            toEqualInt 1),

    should("return number of failures at forth position when success", fn () =>
        expect (#4(should("description", fn _ => "pass")))
            toEqualInt 0),

    should("return number of failures at forth position when failing", fn () =>
        expect (#4(should("description", fn _ => "FAIL")))
            toEqualInt 1)]
])
