fun expect it f = f(it)

fun toEqual value = fn result =>
    if result = value then "pass" else "FAIL"

fun toNotEqual value = fn result =>
    if result <> value then "pass" else "FAIL"

fun toBe value = toEqual value

fun toNotBe value = toNotEqual value

fun toThrow callback = fn exc =>
    (callback(); "FAIL: did not raise " ^ (exnName exc))
    handle exc => "pass"
