structure Assert :>
sig
    val assertEqual       : ''a * ''a -> string
    val assertNotEqual    : ''a * ''a -> string

    val assertEqualStr    : string * string -> string
    val assertNotEqualStr : string * string -> string
    val assertHasPrefix   : string * string -> string

    val assertEqualInt    : int * int -> string
    val assertNotEqualInt : int * int -> string
end =
struct
    fun assertEqual(result, value) =
        if result = value
        then "pass"
        else "FAIL"

    fun assertNotEqual(result, value) =
        if result <> value
        then "pass"
        else "FAIL"

    fun assertEqualStr(result, value) =
        if result = value
        then "pass"
        else concat ["FAIL: expected ", result, " to equal ", value]

    fun assertNotEqualStr(result, value) =
        if result <> value
        then "pass"
        else concat ["FAIL: expected ", result, " not to equal ", value]

    fun assertHasPrefix(result, value) =
        if String.isPrefix value result
        then "pass"
        else concat ["FAIL: expected ", result, " to have prefix ", value]

    fun assertEqualInt(result, value) =
        if result = value
        then "pass"
        else concat ["FAIL: expected ", Int.toString result,
                     " to equal ", Int.toString value]

    fun assertNotEqualInt(result, value) =
        if result <> value
        then "pass"
        else concat ["FAIL: expected ", Int.toString result,
                     " to not equal ", Int.toString value]
end (* of struct *)
