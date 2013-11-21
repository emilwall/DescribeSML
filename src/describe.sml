structure Describe = struct
fun suite((description, status)) =
    print (concat ["\n", description, status, "\n\n"])

fun describe sut specs =
    let
        val failures =
            List.filter (fn (_, result) => SpecReporter.isFailure result) specs
        val resultReport = map (SpecReporter.report "concise") specs
        val failureReport = map (SpecReporter.report "verbose") failures
    in
        (concat ["Ran ",
            Int.toString (length specs),
            " specs for ",
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
            else "pass"))
    end

fun should(description, spec) =
    (description, spec())
    handle exc => (description, "FAIL: raised " ^ exnName exc)
end
