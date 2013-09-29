fun isConsonant c = List.exists (fn c' => c = c') (explode "bcdfghjklmnpqrstvwxz")

fun RobberLanguage s = s ^ "o" ^ s
