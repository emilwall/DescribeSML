structure RobberLanguage :>
sig
   val isConsonant : char -> bool
   val translate : string -> string
end =
struct
    val consonants = explode "cdfghjklmnpqrstvwxz"

    fun isConsonant c =
        List.exists (fn c' => c = c' orelse Char.toLower c = c') consonants

    fun process [] = []
      | process (c::cs) =
        if isConsonant c
        then (Char.toUpper c) :: #"o" :: c :: process cs
        else c :: process cs

    val translate = implode o process o explode
end
