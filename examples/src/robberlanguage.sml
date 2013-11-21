structure RobberLanguage =
struct
    local
        val consonants = explode "cdfghjklmnpqrstvwxz"
    in
        fun isConsonant c =
            List.exists (fn c' => c = c' orelse Char.toLower c = c') consonants
    end

    val translate =
        let
            fun process [] = []
              | process (c::cs) =
                if isConsonant c
                then (Char.toUpper c) :: #"o" :: c :: process cs
                else c :: process cs
        in
            implode o process o explode
        end
end
