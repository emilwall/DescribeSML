structure Expect = struct
fun expect it f = f(it)

local
    fun checkWith operator value result =
        if operator(value, result) then "pass" else "FAIL"
in
    fun toEqual value = checkWith (op =) value

    fun toNotEqual value = checkWith (op <>) value

    val toBe = toEqual

    val toNotBe = toNotEqual
end

local
    fun checkStrWith operator relation result value =
        if operator(value, result)
        then "pass"
        else concat ["FAIL: expected \"", result,
                     "\" to ", relation, " \"", value, "\""]
in
    fun toEqualStr result = checkStrWith (op =) "equal" result

    fun toNotEqualStr result = checkStrWith (op <>) "NOT equal" result

    val toBeStr = toEqualStr

    val toNotBeStr = toNotEqualStr
end

local
    fun checkIntWith operator relation result value =
        if operator(value, result)
        then "pass"
        else concat ["FAIL: expected \"", Int.toString(result),
                     "\" to ", relation, " \"", Int.toString(value), "\""]
in
    fun toEqualInt result = checkIntWith (op =) "equal" result

    fun toNotEqualInt result = checkIntWith (op <>) "NOT equal" result

    val toBeInt = toEqualInt

    val toNotBeInt = toNotEqualInt
end

local
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
in
    fun toContain result = checkListWith "contain" result

    fun toNotContain result = checkListWith "not contain" result

    fun toBeginWith result = checkListWith "begin with" result

    fun toNotBeginWith result = checkListWith "not begin with" result

    fun toEndWith result = checkListWith "end with" result

    fun toNotEndWith result = checkListWith "not end with" result
end

local
    structure RE = RegExpFn (
        structure P = AwkSyntax
        structure E = BackTrackEngine)
in
    fun toMatch result value =
        case StringCvt.scanString (RE.find (RE.compileString value)) result of
            NONE => concat ["FAIL: expected \"", result,
                            "\" to match \"", value, "\""]
          | SOME match => "pass"
end

fun toThrow callback exc1 =
    (callback(); "FAIL: did not raise " ^ (exnName exc1))
    handle exc2 =>
        if exnName exc2 = exnName exc1
            andalso toMatch (exnMessage exc2) (exnMessage exc1) = "pass"
        then "pass"
        else concat ["FAIL: raised ", (exnName exc2),
                     " with message \"", (exnMessage exc2),
                     "\" instead of ", (exnName exc1),
                     " with message \"", (exnMessage exc1), "\""]
end (* of struct *)
