structure SpecReporter = struct
fun isFailure result =
    String.substring(result, 0, 4) = "FAIL"

fun report "verbose" (description, result) =
    concat [if String.isPrefix "Ran " description then "" else "should ",
            description, ": ", result, "\n"]
  | report _ (_, result) =
    if isFailure result then "!" else "."
end
