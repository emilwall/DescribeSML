use "../lib/describe.sml";
use "../lib/expect.sml";

val _ = describe "toContain"
    [fn it => "should fail for empty list",
     fn _ => expect (toContain [] 0) toNotEqualStr "pass",

     fn it => "should fail when list does not contain value",
     fn _ => expect (toContain [1, 3] 2) toNotEqualStr "pass",

     fn it => "should pass when list contains value",
     fn _ => expect (toContain [1, 2, 3] 2) toEqualStr "pass",

     fn it => "should work on char values",
     fn _ => expect (toContain (explode "[1, 2, 3]") #"2") toEqualStr "pass",

     fn it => "should work on string values",
     fn _ => expect (toContain ["ab", "cd", "ef"] "ab") toEqualStr "pass"]

val _ = describe "toNotContain"
    [fn it => "should pass for empty list",
     fn _ => expect (toNotContain [] 0) toEqualStr "pass",

     fn it => "should pass when list does not contain value",
     fn _ => expect (toNotContain [1, 3] 2) toEqualStr "pass",

     fn it => "should fail when list contains value",
     fn _ => expect (toNotContain [1, 2, 3] 2) toNotEqualStr "pass",

     fn it => "should work on char values",
     fn _ => expect (toNotContain (explode "[1, 3]") #"2") toEqualStr "pass",

     fn it => "should work on string values",
     fn _ => expect (toNotContain ["abc", "def"] "ab") toEqualStr "pass"]

val _ = describe "toMatch"
    [fn it => "should match empty string with end terminal",
     fn _ => expect (toMatch "" "$") toEqualStr "pass",

     fn it => "should match anything with end terminal",
     fn _ => expect (toMatch "abc" "$") toEqualStr "pass",

     fn it => "should match anything with start of input",
     fn _ => expect (toMatch "abc" "^") toEqualStr "pass",

     fn it => "should match empty string with start immediately followed by end",
     fn _ => expect (toMatch "" "^$") toEqualStr "pass",

     fn it => "should not match non-empty string with start immediately followed by end",
     fn _ => expect (toMatch "abc" "^$") toNotEqualStr "pass",

     fn it => "should match exact string",
     fn _ => expect (toMatch "abc" "^abc$") toEqualStr "pass",

     fn it => "should not match empty string with non-empty regex",
     fn _ => expect (toMatch "" "abc") toNotEqualStr "pass",

     fn it => "should not match a string with characters in different order",
     fn _ => expect (toMatch "abc" "cba$") toNotEqualStr "pass",

     fn it => "should match repeated characters with star notation",
     fn _ => expect (toMatch "aaa" "^a*$") toEqualStr "pass",

     fn it => "should match numbers with interval",
     fn _ => expect (toMatch "123" "^[0-9]*$") toEqualStr "pass"]
