fun expect it f = f(it);

fun toEqual value = fn result =>
    if result = value then
        "pass"
    else
        "FAIL"

fun describe sut specs =
    let
        fun runSpecs [] acc = concat(rev acc)
            | runSpecs (x::y::zs) acc =
                runSpecs zs ((x() ^ ": " ^ y() ^ "\n") :: acc)
            | runSpecs (y::zs) acc = runSpecs ((fn _ => "unspecified")::y::[]) acc
    in
        print ("Ran " ^
            (Int.toString ((length specs) div 2)) ^
            " specs:\n" ^
            runSpecs specs [])
    end;

fun hello you =
    "Hello " ^ you ^ "!";

describe "hello"
    [fn it => "should say hello",
     fn _ => expect (hello "World") toEqual("Hello World!"),

     fn it => "should greet you",
     fn _ => expect (hello "You") toEqual("Hello You!")];
