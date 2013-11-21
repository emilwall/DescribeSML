structure Describe = struct
fun suite((description, status, _)) =
    print (concat ["\n", description, status, "\n\n"])

fun describe sut specs =
    let
        val failures =
            List.filter (fn (_, result, _) => SpecReporter.isFailure result) specs
        val resultReport = map (SpecReporter.report "concise") specs
        val failureReport = map (SpecReporter.report "verbose") failures
        val nestedLength = foldr (fn ((_, _, n), acc) => acc + n) 0 specs
    in
        (concat ["Ran ",
            Int.toString (length specs),
            (if List.exists (fn (_, _, n) => n <> 1) specs
                then concat [" nested describes (total ",
                             Int.toString nestedLength,
                             " specs) for "]
                else " specs for "),
            sut,
            ":\n\n",
            concat resultReport,
            concat (if length failures > 0
                then "\n\n" :: failureReport
                else ["\n"]),
            "\nFailures: ",
            Int.toString(length failures),
            "\n===========\n\n"],
        (if length failures > 0
            then "FAIL: a nested spec failed, see report above."
            else "pass"),
        nestedLength)
    end

fun should(description, spec) =
    (description, spec(), 1)
    handle exc => (description, "FAIL: raised " ^ exnName exc, 1)
end
