CM.make "$/regexp-lib.cm";
structure RE = RegExpFn (
    structure P = AwkSyntax
    structure E = BackTrackEngine);

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
        if operator(value, result) then
            "pass"
        else
            concat ["FAIL: expected \"", result, "\" to ", relation, " \"", value, "\""]
in
    fun toEqualStr result = checkStrWith (op =) "equal" result

    fun toNotEqualStr result = checkStrWith (op <>) "NOT equal" result

    val toBeStr = toEqualStr

    val toNotBeStr = toNotEqualStr
end

local
    fun checkIntWith operator relation result value =
        if operator(value, result) then
            "pass"
        else
            concat ["FAIL: expected \"", Int.toString(result), "\" to ", relation, " \"", Int.toString(value), "\""]
in
    fun toEqualInt result = checkIntWith (op =) "equal" result

    fun toNotEqualInt result = checkIntWith (op <>) "NOT equal" result

    val toBeInt = toEqualInt

    val toNotBeInt = toNotEqualInt
end

local
    fun checkListWith relation result value =
    let
        val containsValue = List.exists (fn a => a = value) result
    in
        if (relation = "contain") = containsValue then
            "pass"
        else
            concat ["FAIL: Expected List to ", relation, " value"]
    end
in
    fun toContain result = checkListWith "contain" result

    fun toNotContain result = checkListWith "not contain" result
end

fun toMatch result value =
    case StringCvt.scanString (RE.find (RE.compileString value)) result of
        NONE => concat ["FAIL: expected \"", result, "\" to match \"", value, "\""]
      | SOME match => "pass"

fun toThrow callback exc =
    (callback(); "FAIL: did not raise " ^ (exnName exc))
    handle exc => "pass"
