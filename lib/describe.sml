fun describe sut specs =
    let
        fun report x y =
            concat [x(), ": ", y(), "\n"]
        fun runSpecs [] acc = concat(rev acc)
            | runSpecs (x::y::zs) acc =
                runSpecs zs ((report x y) :: acc)
            | runSpecs (y::zs) acc = runSpecs ((fn _ => "unspecified")::y::[]) acc
    in
        print (concat ["Ran ",
            (Int.toString ((length specs) div 2)),
            " specs:\n",
            runSpecs specs []])
    end
