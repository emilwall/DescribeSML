use "../lib/spec-runner.sml";
use "../lib/spec-reporter.sml";

fun describe sut specs =
    let
        val results = runSpecs specs []
        val failures = List.filter (fn (_, result) => isFailure result) results
        val resultReport = map (fn (expectation, result) => report expectation result "concise") results
        val failureReport = map (fn (expectation, result) => report expectation result "verbose") failures
    in
        print (concat ["Ran ",
            Int.toString ((length specs + 1) div 2),
            " specs:\n\n",
            concat resultReport,
            concat (if length failures > 0
                then ("\n\n" :: failureReport)
                else ["\n"]),
            "\nFailures: ",
            Int.toString(length failures),
            "\n"])
    end
