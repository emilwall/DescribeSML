structure SpecReporter = struct
fun isFailure result =
    String.substring(result, 0, 4) = "FAIL"

fun report "verbose" (description, result, _) =
    concat [if String.isPrefix "Ran " description then "" else "should ",
            description, if size result > 4 andalso String.isPrefix "Ran " description then "" else ": ", result, "\n"]
  | report _ (_, result, _) =
    if isFailure result then "!" else "."
end
