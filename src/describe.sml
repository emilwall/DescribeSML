structure Describe = struct
fun suite((description, status, specs, failures)) =
    print (concat ["\n", description, status, "Total failures: ",
                   Int.toString failures, "\n=================",
                   if failures >= 10 then "=" else "", "\n\n"])

fun describe sut specs =
    let
        val failures = List.filter (fn (_, _, _, n) => n > 0) specs
        val resultReport = map (SpecReporter.report "concise") specs
        val failureReport = map (SpecReporter.report "verbose") failures
        val nestedLength = foldr (fn ((_, _, n, _), acc) => acc + n) 0 specs
    in
        (concat ["Ran ",
            Int.toString (length specs),
            (if List.exists (fn (_, _, n, _) => n <> 1) specs
                then concat [" nested describes (total ",
                             Int.toString nestedLength,
                             " specs) for "]
                else " specs for "),
            sut,
            ":\n\n",
            concat resultReport,
            "\n\n",
            if length failures > 0
            then concat failureReport
            else ""
            ],
        "",
        nestedLength,
        foldl (fn ((_, _, _, n), acc) => acc + n) 0 failures)
    end

fun should(description, spec) =
    let
        val result = spec()
    in
        (description, result, 1, if SpecReporter.isFailure result then 1 else 0)
    end
    handle exc => (description, "FAIL: raised " ^ exnName exc, 1, 1)
end
