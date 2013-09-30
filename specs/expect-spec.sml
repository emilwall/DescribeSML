use "../lib/describe.sml";
use "../lib/expect.sml";

val _ = describe "toContain"
    [fn it => "should fail for empty list",
     fn _ => expect (toContain [] 0) toNotEqualStr "pass",

     fn it => "should fail when list does not contain value",
     fn _ => expect (toContain [1, 3] 2) toNotEqualStr "pass",

     fn it => "should pass when list contains value",
     fn _ => expect (toContain [1, 2, 3] 2) toEqualStr "pass"]