use "../lib/describe.sml";
use "../lib/expect.sml";

val _ = describe "toContain"
    [should("fail for empty list", fn () =>
        expect (toContain [] 0) toNotEqualStr "pass"),

     should("fail when list does not contain value", fn () =>
        expect (toContain [1, 3] 2) toNotEqualStr "pass"),

     should("pass when list contains value", fn () =>
        expect (toContain [1, 2, 3] 2) toEqualStr "pass"),

     should("work on char values", fn () =>
        expect (toContain (explode "[1, 2, 3]") #"2") toEqualStr "pass"),

     should("work on string values", fn () =>
        expect (toContain ["ab", "cd", "ef"] "ab") toEqualStr "pass")]

val _ = describe "toNotContain"
    [should("pass for empty list", fn () =>
        expect (toNotContain [] 0) toEqualStr "pass"),

     should("pass when list does not contain value", fn () =>
        expect (toNotContain [1, 3] 2) toEqualStr "pass"),

     should("fail when list contains value", fn () =>
        expect (toNotContain [1, 2, 3] 2) toNotEqualStr "pass"),

     should("work on char values", fn () =>
        expect (toNotContain (explode "[1, 3]") #"2") toEqualStr "pass"),

     should("work on string values", fn () =>
        expect (toNotContain ["abc", "def"] "ab") toEqualStr "pass")]

val _ = describe "toBeginWith"
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
        expect (toBeginWith ["ab", "cd", "ef"] "ab") toEqualStr "pass")]

val _ = describe "toNotBeginWith"
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
        expect (toNotBeginWith ["abc", "def"] "ab") toEqualStr "pass")]

val _ = describe "toEndWith"
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
        expect (toEndWith ["ab", "cd", "ef"] "ef") toEqualStr "pass")]

val _ = describe "toNotEndWith"
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
        expect (toNotEndWith ["abc", "def"] "ab") toEqualStr "pass")]

val _ = describe "toMatch"
    [should("match empty string with end terminal", fn () =>
        expect (toMatch "" "$") toEqualStr "pass"),

     should("match anything with end terminal", fn () =>
        expect (toMatch "abc" "$") toEqualStr "pass"),

     should("match anything with start of input", fn () =>
        expect (toMatch "abc" "^") toEqualStr "pass"),

     should("match empty string with start immediately followed by end", fn () =>
        expect (toMatch "" "^$") toEqualStr "pass"),

     should("not match non-empty string with start immediately followed by end", fn () =>
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
        expect (toMatch "123" "^[0-9]*$") toEqualStr "pass")]
