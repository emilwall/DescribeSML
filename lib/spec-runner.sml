use "../lib/spec-reporter.sml";

fun runSpecs [spec] [] =
    report "result" (spec())
  | runSpecs [] reports =
    concat(rev reports)
  | runSpecs (expectation::spec::specs) reports =
    runSpecs specs (report (expectation()) (spec()) :: reports)
  | runSpecs (spec::specs) reports =
    raise Fail "Multiple specs should be pairwise coupled with their expectations"
