use "../lib/spec-runner.sml";
use "../lib/spec-reporter.sml";

fun describe sut specs =
    let
        val results = runSpecs specs []
        val failures = List.filter (fn (_, result) => isFailure result) results
        val resultReport = map (report "concise") results
        val failureReport = map (report "verbose") failures
    in
        print (concat ["Ran ",
            Int.toString ((length specs + 1) div 2),
            " specs for ",
            sut,
            ":\n\n",
            concat resultReport,
            concat (if length failures > 0
                then "\n\n" :: failureReport
                else ["\n"]),
            "\nFailures: ",
            Int.toString(length failures),
            "\n===========\n\n"])
    end
