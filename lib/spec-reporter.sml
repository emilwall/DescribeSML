fun isFailure result =
	String.substring(result, 0, 4) = "FAIL"

fun report "verbose" (description, result) =
    concat ["should ", description, ": ", result, "\n"]
  | report _ (_, result) =
    if isFailure result then "!" else "."

fun suite((description, status)) =
    print (concat ["\n", description, status, "\n\n"])
