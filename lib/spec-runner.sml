fun runSpecs [spec] [] =
    [("result", spec())]
  | runSpecs [] reports =
    rev reports
  | runSpecs (expectation::spec::specs) reports =
    runSpecs specs ((expectation(), spec()) :: reports)
  | runSpecs (spec::specs) reports =
    raise Fail "Multiple specs should be pairwise coupled with their expectations"
