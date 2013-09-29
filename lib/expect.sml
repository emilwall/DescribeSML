fun expect it f = f(it)

local
    fun ternary operator value = fn result =>
        if operator(value, result) then "pass" else "FAIL"
in
    fun toEqual value = ternary (op =) value

    fun toNotEqual value = ternary (op <>) value
end

fun toBe value = toEqual value

fun toNotBe value = toNotEqual value

fun toThrow callback = fn exc =>
    (callback(); "FAIL: did not raise " ^ (exnName exc))
    handle exc => "pass"
