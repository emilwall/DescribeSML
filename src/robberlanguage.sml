structure RobberLanguage =
struct
    fun isConsonant c = List.exists (fn c' => c = c') (explode "bcdfghjklmnpqrstvwxz")
    fun translate s =
    let
        fun process [] acc =
            rev acc
          | process (c::cs) acc =
            process cs (if isConsonant c then
                            c :: #"o" :: c :: acc
                        else
                            c :: acc)

    in
        implode(process (explode s) [])
    end
end
