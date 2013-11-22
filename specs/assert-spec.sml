CM.make "../describe.cm";
CM.make "$/regexp-lib.cm";
open Describe;
open Assert;

suite (describe "assertions" [
describe "assertEqual" [
    should ("pass when result is equal to value", fn () =>
        assertEqual (assertEqual(1 + 1, 2), "pass")),

    should ("fail when result is not equal to value", fn () =>
        assertEqual (assertEqual(1 + 3, 2), "FAIL"))],

describe "assertNotEqual" [
    should ("fail when result is equal to value", fn () =>
        assertEqual (assertNotEqual(1 + 1, 2), "FAIL")),

    should ("pass when result is not equal to value", fn () =>
        assertEqual (assertNotEqual(1 + 3, 2), "pass"))],

describe "assertHasPrefix" [
    should ("pass when result begins with value", fn () =>
        assertEqualStr (assertHasPrefix("abc", "ab"), "pass")),

    should ("fail when result does not begin with value", fn () =>
        assertEqualStr (assertHasPrefix("1 + 1", "2"),
                        "FAIL: expected 1 + 1 to have prefix 2"))],

describe "assertEqualStr" [
    should ("pass when result is equal to value", fn () =>
        assertEqual (assertEqualStr("a" ^ "bc", "abc"), "pass")),

    should ("fail when result is not equal to value", fn () =>
        assertNotEqual (assertEqualStr("1 + 1", "2"), "pass"))],

describe "assertNotEqualStr" [
    should ("fail when result is equal to value", fn () =>
        assertHasPrefix (assertNotEqualStr("a" ^ "bc", "abc"), "FAIL")),

    should ("pass when result is not equal to value", fn () =>
        assertEqualStr (assertNotEqualStr("1 + 1", "2"), "pass"))],

describe "assertEqualInt" [
    should ("pass when result is equal to value", fn () =>
        assertEqualStr (assertEqualInt(1 + 1, 2), "pass")),

    should ("fail with detailed message " ^
            "when result is not equal to value", fn () =>
        assertEqualStr (assertEqualInt(1 + 3, 2),
                        "FAIL: expected 4 to equal 2"))],

describe "assertNotEqualInt" [
    should ("fail when result is equal to value", fn () =>
        assertHasPrefix (assertNotEqualInt(1 + 1, 2), "FAIL")),

    should ("pass when result is not equal to value", fn () =>
        assertEqualStr (assertNotEqualInt(1 + 3, 2), "pass"))]
])
