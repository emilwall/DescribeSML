use "../lib/spec-runner.sml";

fun describe sut specs =
    print (concat ["Ran ",
        (Int.toString ((length specs) div 2)),
        " specs:\n",
        runSpecs specs []])
