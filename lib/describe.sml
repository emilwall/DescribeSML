fun describe sut specs =
    let
        fun runSpecs [] acc = concat(rev acc)
            | runSpecs (x::y::zs) acc =
                runSpecs zs ((concat [x(), ": ", y(), "\n"]) :: acc)
            | runSpecs (y::zs) acc = runSpecs ((fn _ => "unspecified")::y::[]) acc
    in
        print (concat ["Ran ",
            (Int.toString ((length specs) div 2)),
            " specs:\n",
            runSpecs specs []])
    end
