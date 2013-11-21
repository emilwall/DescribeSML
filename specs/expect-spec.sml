CM.make "../describe.cm";
open Describe;
open Expect;

suite (describe "matchers" [
describe "toContain"
    [should("fail for empty list", fn () =>
        expect (toContain [] 0) toNotEqualStr "pass"),

     should("fail when list does not contain value", fn () =>
        expect (toContain [1, 3] 2) toNotEqualStr "pass"),

     should("pass when list contains value", fn () =>
        expect (toContain [1, 2, 3] 2) toEqualStr "pass"),

     should("work on char values", fn () =>
        expect (toContain (explode "[1, 2, 3]") #"2") toEqualStr "pass"),

     should("work on string values", fn () =>
        expect (toContain ["ab", "cd", "ef"] "ab") toEqualStr "pass")],

describe "toNotContain"
    [should("pass for empty list", fn () =>
        expect (toNotContain [] 0) toEqualStr "pass"),

     should("pass when list does not contain value", fn () =>
        expect (toNotContain [1, 3] 2) toEqualStr "pass"),

     should("fail when list contains value", fn () =>
        expect (toNotContain [1, 2, 3] 2) toNotEqualStr "pass"),

     should("work on char values", fn () =>
        expect (toNotContain (explode "[1, 3]") #"2") toEqualStr "pass"),

     should("work on string values", fn () =>
        expect (toNotContain ["abc", "def"] "ab") toEqualStr "pass")],

describe "toBeginWith"
    [should("fail for empty list", fn () =>
        expect (toBeginWith [] 0) toNotEqualStr "pass"),

     should("fail when list does not contain value", fn () =>
        expect (toBeginWith [1, 3] 2) toNotEqualStr "pass"),

     should("fail when list contains but does not begin with value", fn () =>
        expect (toBeginWith [1, 2, 3] 2) toNotEqualStr "pass"),

     should("pass when list begins with value", fn () =>
        expect (toBeginWith [1, 2, 3] 1) toEqualStr "pass"),

     should("work on char values", fn () =>
        expect (toBeginWith (explode "[1, 2, 3]") #"[") toEqualStr "pass"),

     should("work on string values", fn () =>
        expect (toBeginWith ["ab", "cd", "ef"] "ab") toEqualStr "pass")],

describe "toNotBeginWith"
    [should("pass for empty list", fn () =>
        expect (toNotBeginWith [] 0) toEqualStr "pass"),

     should("pass when list does not contain value", fn () =>
        expect (toNotBeginWith [1, 3] 2) toEqualStr "pass"),

     should("pass when list contains but does not begin with value", fn () =>
        expect (toNotBeginWith [1, 2, 3] 2) toEqualStr "pass"),

     should("fail when list begins with value", fn () =>
        expect (toNotBeginWith [1, 2, 3] 1) toNotEqualStr "pass"),

     should("work on char values", fn () =>
        expect (toNotBeginWith (explode "[1, 2, 3]") #"1") toEqualStr "pass"),

     should("work on string values", fn () =>
        expect (toNotBeginWith ["abc", "def"] "ab") toEqualStr "pass")],

describe "toEndWith"
    [should("fail for empty list", fn () =>
        expect (toEndWith [] 0) toNotEqualStr "pass"),

     should("fail when list does not contain value", fn () =>
        expect (toEndWith [1, 3] 2) toNotEqualStr "pass"),

     should("fail when list contains but does not end with value", fn () =>
        expect (toEndWith [1, 2, 3] 2) toNotEqualStr "pass"),

     should("fail when list begins with value", fn () =>
        expect (toEndWith [1, 2, 3] 1) toNotEqualStr "pass"),

     should("pass when list ends with value", fn () =>
        expect (toEndWith [1, 2, 3] 3) toEqualStr "pass"),

     should("work on char values", fn () =>
        expect (toEndWith (explode "[1, 2, 3]") #"]") toEqualStr "pass"),

     should("work on string values", fn () =>
        expect (toEndWith ["ab", "cd", "ef"] "ef") toEqualStr "pass")],

describe "toNotEndWith"
    [should("pass for empty list", fn () =>
        expect (toNotEndWith [] 0) toEqualStr "pass"),

     should("pass when list does not contain value", fn () =>
        expect (toNotEndWith [1, 3] 2) toEqualStr "pass"),

     should("pass when list contains but does not begin with value", fn () =>
        expect (toNotEndWith [1, 2, 3] 2) toEqualStr "pass"),

     should("pass when list begins with value", fn () =>
        expect (toNotEndWith [1, 2, 3] 1) toEqualStr "pass"),

     should("fail when list ends with value", fn () =>
        expect (toNotEndWith [1, 2, 3] 3) toNotEqualStr "pass"),

     should("work on char values", fn () =>
        expect (toNotEndWith (explode "[1, 2, 3]") #"3") toEqualStr "pass"),

     should("work on string values", fn () =>
        expect (toNotEndWith ["abc", "def"] "ab") toEqualStr "pass")],

describe "toMatch"
    [should("match empty string with end terminal", fn () =>
        expect (toMatch "" "$") toEqualStr "pass"),

     should("match anything with end terminal", fn () =>
        expect (toMatch "abc" "$") toEqualStr "pass"),

     should("match anything with start of input", fn () =>
        expect (toMatch "abc" "^") toEqualStr "pass"),

     should("match empty string with start followed by end", fn () =>
        expect (toMatch "" "^$") toEqualStr "pass"),

     should("not match non-empty string with start followed by end", fn () =>
        expect (toMatch "abc" "^$") toNotEqualStr "pass"),

     should("match exact string", fn () =>
        expect (toMatch "abc" "^abc$") toEqualStr "pass"),

     should("not match empty string with non-empty regex", fn () =>
        expect (toMatch "" "abc") toNotEqualStr "pass"),

     should("not match a string with characters in different order", fn () =>
        expect (toMatch "abc" "cba$") toNotEqualStr "pass"),

     should("match repeated characters with star notation", fn () =>
        expect (toMatch "aaa" "^a*$") toEqualStr "pass"),

     should("match numbers with interval", fn () =>
        expect (toMatch "123" "^[0-9]*$") toEqualStr "pass")],

describe "toThrow"
    [should("fail when no exception is thrown", fn () =>
        expect (toThrow (fn _ => 0) Empty) toNotEqualStr "pass"),

     should("pass when specified exception is thrown", fn () =>
        expect (toThrow (fn _ => raise Empty) Empty) toEqualStr "pass"),

     should("fail when another exception is thrown", fn () =>
        expect (toThrow (fn _ => raise Domain) Empty) toNotEqualStr "pass"),

     should("handle exceptions with messages", fn () =>
        expect (toThrow (fn _ => raise (Fail "msg")) (Fail "msg"))
            toEqualStr "pass"),

     should("fail when exception message differs", fn () =>
        expect (toThrow (fn _ => raise (Fail "msg")) (Fail "another"))
            toNotEqualStr "pass"),

     should("put first exception message in quotes", fn () =>
        expect (toThrow (fn _ => raise (Fail "msg")) (Fail "another"))
            toMatch "\"Fail: msg\""),

     should("put last exception message in quotes", fn () =>
        expect (toThrow (fn _ => raise (Fail "msg")) (Fail "another"))
            toMatch "\"Fail: another\""),

     should("match empty exception string to any other message", fn () =>
        expect (toThrow (fn _ => raise (Fail "msg")) (Fail ""))
            toEqualStr "pass"),

     should("not match non-empty string with empty string", fn () =>
        expect (toThrow (fn _ => raise (Fail "")) (Fail "msg"))
            toMatch "FAIL")],

describe "toNotThrow"
    [should("pass when no exception is thrown", fn () =>
        expect (toNotThrow (fn _ => 0) Empty) toEqualStr "pass"),

     should("fail when specified exception is thrown", fn () =>
        expect (toNotThrow (fn _ => raise Empty) Empty) toMatch "FAIL"),

     should("pass when another exception is thrown", fn () =>
        expect (toNotThrow (fn _ => raise Domain) Empty) toEqualStr "pass"),

     should("fail when exceptions have same messages", fn () =>
        expect (toNotThrow (fn _ => raise (Fail "msg")) (Fail "msg"))
            toNotEqualStr "pass"),

     should("pass when exception message differs", fn () =>
        expect (toNotThrow (fn _ => raise (Fail "msg")) (Fail "another"))
            toEqualStr "pass"),

     should("match empty exception string to any other message", fn () =>
        expect (toNotThrow (fn _ => raise (Fail "msg")) (Fail ""))
            toMatch "FAIL"),

     should("not match non-empty string with empty string", fn () =>
        expect (toNotThrow (fn _ => raise (Fail "")) (Fail "msg"))
            toEqualStr "pass")]
])