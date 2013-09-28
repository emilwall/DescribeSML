structure bdmlMatcher =
struct
  val result = (ref "")
  fun toEqual value = !result = value
end;

fun expect it = (bdmlMatcher.result := it; 

fun describe sut specs =
  let
    fun runSpecs [] acc = concat(rev acc)
      | runSpecs (x::y::zs) acc =
        runSpecs zs ((x() ^ ": " ^ y() ^ "\n") :: acc)
      | runSpecs (y::zs) acc = runSpecs ["unspecified", y] acc
  in
    print ("Ran " ^
      (str (length(specs)/2)) ^
      " specs:\n" ^
      runSpecs specs [])
  end;

fun hello you =
  "Hello " ^ you ^ "!";

describe "hello"
  [fn it => "should say hello",
   fn _ => expect (hello "World") toEqual("Hello World!"),

   fn it => "should greet you",
   fn _ => expect(hello "You").toEqual("Hello You!")];
