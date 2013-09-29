structure RobberLanguage =
struct
    fun isConsonant c = List.exists (fn c' => c = c') (explode "bcdfghjklmnpqrstvwxz")
    fun translate s = s ^ "o" ^ s
end
