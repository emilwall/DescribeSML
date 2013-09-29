fun expect it f = f(it)

local
    fun ternary operator result value =
        if operator(result, value) then "pass" else "FAIL"
in
    fun toEqual result = ternary (op =) result

    fun toNotEqual result = ternary (op <>) result

    fun toBe result = ternary (op =) result

    fun toNotBe result = ternary (op <>) result
end

fun toThrow callback = fn exc =>
    (callback(); "FAIL: did not raise " ^ (exnName exc))
    handle exc => "pass"
