structure RobberLanguage =
struct
    fun isConsonant c =
        let
            val consonants = explode "bcdfghjklmnpqrstvwxz"
        in
            List.exists (fn c' => c = c' orelse (Char.toLower c) = c') consonants
        end

    fun translate s =
    let
        fun process [] acc =
            rev acc
          | process (c::cs) acc =
            process cs (if isConsonant c then
                            c :: #"o" :: (Char.toLower c) :: acc
                        else
                            c :: acc)

    in
        implode(process (explode s) [])
    end
end
