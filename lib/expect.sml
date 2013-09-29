fun expect it f = f(it)

fun toEqual value = fn result =>
    if result = value then
        "pass"
    else
        "FAIL"
