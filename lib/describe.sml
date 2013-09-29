use "../lib/spec-runner.sml";
use "../lib/spec-reporter.sml";

fun describe sut specs =
    let
        val results = runSpecs specs []
        val failures = List.filter (fn (_, result) => isFailure result) results
        val reportMode = if length results = 1 then "verbose" else "concise"
        val resultReport = map (fn (expectation, result) => report expectation result reportMode) results
        val failureReport = map (fn (expectation, result) => report expectation result "verbose") failures
    in
        print (concat ["Ran ",
            Int.toString ((length specs + 1) div 2),
            " specs:\n\n",
            concat (if length failures > 0 then failureReport else resultReport),
            "\n\nFailures: ",
            Int.toString(length failures),
            "\n"])
    end
