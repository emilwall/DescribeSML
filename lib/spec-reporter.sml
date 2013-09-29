fun isFailure result =
	String.substring(result, 0, 4) = "FAIL"

fun report "verbose" (expectation, result) =
    concat [expectation, ": ", result, "\n"]
  | report _ (expectation, result) =
    if isFailure result then "!" else "."
