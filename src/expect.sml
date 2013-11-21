structure Expect :>
sig
    val expect : 'a -> ('a -> 'b) -> 'b

    val toEqual    : ''a -> ''a -> string
    val toNotEqual : ''a -> ''a -> string
    val toBe       : ''a -> ''a -> string
    val toNotBe    : ''a -> ''a -> string

    val toEqualStr    : string -> string -> string
    val toNotEqualStr : string -> string -> string
    val toBeStr       : string -> string -> string
    val toNotBeStr    : string -> string -> string

    val toEqualInt    : int -> int -> string
    val toNotEqualInt : int -> int -> string
    val toBeInt       : int -> int -> string
    val toNotBeInt    : int -> int -> string

    val toContain      : ''a list -> ''a -> string
    val toNotContain   : ''a list -> ''a -> string
    val toBeginWith    : ''a list -> ''a -> string
    val toNotBeginWith : ''a list -> ''a -> string
    val toEndWith      : ''a list -> ''a -> string
    val toNotEndWith   : ''a list -> ''a -> string

    val toMatch    : string -> string -> string
    val toNotMatch : string -> string -> string

    val toThrow    : (unit -> 'a) -> exn -> string
    val toNotThrow : (unit -> 'a) -> exn -> string
end =
struct
    fun expect it f = f(it)

    fun checkWith operator value result =
        if operator(value, result) then "pass" else "FAIL"

    fun toEqual value = checkWith (op =) value

    fun toNotEqual value = checkWith (op <>) value

    val toBe = toEqual

    val toNotBe = toNotEqual

    fun checkStrWith operator relation result value =
        if operator(value, result)
        then "pass"
        else concat ["FAIL: expected \"", result,
                     "\" to ", relation, " \"", value, "\""]

    fun toEqualStr result = checkStrWith (op =) "equal" result

    fun toNotEqualStr result = checkStrWith (op <>) "NOT equal" result

    val toBeStr = toEqualStr

    val toNotBeStr = toNotEqualStr

    fun checkIntWith operator relation result value =
        if operator(value, result)
        then "pass"
        else concat ["FAIL: expected \"", Int.toString(result),
                     "\" to ", relation, " \"", Int.toString(value), "\""]

    fun toEqualInt result = checkIntWith (op =) "equal" result

    fun toNotEqualInt result = checkIntWith (op <>) "NOT equal" result

    val toBeInt = toEqualInt

    val toNotBeInt = toNotEqualInt

    fun checkListWith relation result value =
    let
        fun checkNth n = n >= 0
                         andalso length result > n
                         andalso List.nth(result, n) = value
        val containsValue = List.exists (fn a => a = value) result
        val success = case relation of
            "contain" => containsValue
          | "not contain" => not containsValue
          | "begin with" => checkNth 0
          | "not begin with" => not (checkNth 0)
          | "end with" => checkNth (length result - 1)
          | "not end with" => not (checkNth (length result - 1))
    in
        if success
        then "pass"
        else concat ["FAIL: Expected List to ", relation, " value"]
    end

    fun toContain result = checkListWith "contain" result

    fun toNotContain result = checkListWith "not contain" result

    fun toBeginWith result = checkListWith "begin with" result

    fun toNotBeginWith result = checkListWith "not begin with" result

    fun toEndWith result = checkListWith "end with" result

    fun toNotEndWith result = checkListWith "not end with" result

    structure RE = RegExpFn (
        structure P = AwkSyntax
        structure E = BackTrackEngine)

    fun toMatch result value =
        let
            val (success, match) =
                (true, StringCvt.scanString (RE.find (RE.compileString value)))
            handle RegExpSyntax.CannotParse =>
                (false, StringCvt.scanString (RE.find (RE.compileString "$")))
        in
            if success
            then case match result of
                    NONE => concat ["FAIL: expected \"", result,
                                    "\" to match \"", value, "\""]
                  | _ => "pass"
            else "FAIL: raised CannotParse"
        end

    fun toNotMatch result value =
        case toMatch result value of
            "pass" => concat ["FAIL: expected \"", result,
                              "\" not to match \"", value, "\""]
          | _ => "pass"

    fun toThrow callback exc1 =
        (callback(); "FAIL: did not raise " ^ (exnName exc1))
        handle exc2 =>
            if String.isPrefix (exnMessage exc1) (exnMessage exc2)
            then "pass"
            else concat ["FAIL: raised ", exnName exc2,
                         " with message \"", exnMessage exc2,
                         "\" instead of ", exnName exc1,
                         " with message \"", exnMessage exc1, "\""]

    fun toNotThrow callback exc1 =
        (callback(); "pass")
        handle exc2 =>
            if String.isPrefix (exnMessage exc1) (exnMessage exc2)
            then concat ["FAIL: raised ", exnMessage exc2]
            else "pass"
end (* of struct *)
