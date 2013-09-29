fun expect it f = f(it)

local
    fun ternary operator result value =
        if operator(result, value) then "pass" else "FAIL"
in
    fun toEqual result = ternary (op =) result

    fun toNotEqual result = ternary (op <>) result

    val toBe = toEqual

    val toNotBe = toNotEqual
end

local
    fun toStr operator relation value result =
        if operator(value, result) then
            "pass"
        else
            concat ["FAIL: expected ", result, " to ", relation, " ", value]
in
    fun toEqualStr value = toStr (op =) "equal" value

    fun toNotEqualStr value = toStr (op <>) "NOT equal" value

    val toBeStr = toEqualStr

    val toNotBeStr = toNotEqualStr
end

local
    fun toInt operator relation value result =
        if operator(value, result) then
            "pass"
        else
            concat ["FAIL: expected ", Int.toString(result), " to ", relation, " ", Int.toString(value)]
in
    fun toEqualInt value = toInt (op =) "equal" value

    fun toNotEqualInt value = toInt (op <>) "NOT equal" value

    val toBeInt = toEqualInt

    val toNotBeInt = toNotEqualInt
end

fun toThrow callback = fn exc =>
    (callback(); "FAIL: did not raise " ^ (exnName exc))
    handle exc => "pass"
