use "../lib/spec-reporter.sml";

fun describe sut specs =
    let
        val failures = List.filter (fn (_, result) => isFailure result) specs
        val resultReport = map (report "concise") specs
        val failureReport = map (report "verbose") failures
    in
        (print (concat ["Ran ",
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
            "\n===========\n\n"]);
        (sut, if length failures > 0
                then "FAIL: a nested spec failed, see report above."
                else "pass"))
    end

fun should(description, spec) = (description, spec())
