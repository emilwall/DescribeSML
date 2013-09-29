fun describe sut specs =
    let
        fun report expectation result =
            concat [expectation, ": ", result, "\n"]

        fun runSpecs [spec] [] =
            report "result" (spec())
          | runSpecs [] reports =
            concat(rev reports)
          | runSpecs (expectation::spec::specs) reports =
            runSpecs specs (report (expectation()) (spec()) :: reports)
          | runSpecs (spec::specs) reports =
            raise Fail "Multiple specs should be pairwise coupled with their expectations"
    in
        print (concat ["Ran ",
            (Int.toString ((length specs) div 2)),
            " specs:\n",
            runSpecs specs []])
    end
