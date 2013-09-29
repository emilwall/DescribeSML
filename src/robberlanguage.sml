fun isConsonant c = List.exists (fn c' => c = c') (explode "bcdfghjklmnpqrstvwxz")

structure RobberLanguage =
struct
    fun translate s = s ^ "o" ^ s
end
