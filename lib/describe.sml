fun describe sut specs =
    let
        fun report x y =
            concat [x(), ": ", y(), "\n"]
        fun runSpecs [] acc = concat(rev acc)
            | runSpecs [spec] [] =
                spec() ^ "\n"
            | runSpecs (x::y::zs) acc =
                runSpecs zs ((report x y) :: acc)
    in
        print (concat ["Ran ",
            (Int.toString ((length specs) div 2)),
            " specs:\n",
            runSpecs specs []])
    end
