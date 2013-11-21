structure SpecReporter = struct
fun isFailure result =
    String.substring(result, 0, 4) = "FAIL"

fun report "verbose" (description, result, _) =
    let
        val begins_with_ran = String.isPrefix "Ran " description
        val should_omit_colon = size result > 4 andalso begins_with_ran
    in
        concat [if begins_with_ran then "" else "should ",
                description,
                if should_omit_colon then "" else ": ",
                result, "\n"]
    end
  | report _ (_, result, _) =
    if isFailure result then "!" else "."
end
