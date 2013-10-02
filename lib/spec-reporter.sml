fun isFailure result =
	String.substring(result, 0, 4) = "FAIL"

fun report "verbose" (description, result) =
    concat [description, ": ", result, "\n"]
  | report _ (_, result) =
    if isFailure result then "!" else "."
