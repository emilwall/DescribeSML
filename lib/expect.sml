CM.make "$/regexp-lib.cm";
structure RE = RegExpFn (
      structure P = AwkSyntax
      structure E = BackTrackEngine);

fun expect it f = f(it)

local
    fun ternary operator value result =
        if operator(value, result) then "pass" else "FAIL"
in
    fun toEqual value = ternary (op =) value

    fun toNotEqual value = ternary (op <>) value

    val toBe = toEqual

    val toNotBe = toNotEqual
end

local
    fun toStr operator relation result value =
        if operator(value, result) then
            "pass"
        else
            concat ["FAIL: expected \"", result, "\" to ", relation, " \"", value, "\""]
in
    fun toEqualStr result = toStr (op =) "equal" result

    fun toNotEqualStr result = toStr (op <>) "NOT equal" result

    val toBeStr = toEqualStr

    val toNotBeStr = toNotEqualStr
end

local
    fun toInt operator relation result value =
        if operator(value, result) then
            "pass"
        else
            concat ["FAIL: expected \"", Int.toString(result), "\" to ", relation, " \"", Int.toString(value), "\""]
in
    fun toEqualInt result = toInt (op =) "equal" result

    fun toNotEqualInt result = toInt (op <>) "NOT equal" result

    val toBeInt = toEqualInt

    val toNotBeInt = toNotEqualInt
end

fun toContain result value =
    let
        val containsValue = List.exists (fn a => a = value) result
    in
        if containsValue then
            "pass"
        else
            "FAIL: List did not contain expected value"
    end

fun toNotContain result value =
    let
        val containsValue = List.exists (fn a => a = value) result
    in
        if not containsValue then
            "pass"
        else
            "FAIL: Expected list to not contain value"
    end

fun toMatch result value =
    case StringCvt.scanString (RE.find (RE.compileString value)) result of
        NONE => concat ["FAIL: expected \"", result, "\" to match \"", value, "\""]
      | SOME match => "pass"

fun toThrow callback = fn exc =>
    (callback(); "FAIL: did not raise " ^ (exnName exc))
    handle exc => "pass"
