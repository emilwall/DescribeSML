local
    fun fib' limit prev1 prev2 =
        if prev1 + prev2 > limit then
            []
        else
            (prev1 + prev2) :: fib' limit prev2 (prev1 + prev2)
in
    fun fib limit =
        if limit < 1
        then []
        else 1 :: fib' limit 0 1

    fun even_fib limit =
        List.filter (fn x => x mod 2 = 0) (fib limit)
end

val ans = List.foldr (op +) 0 (even_fib 4000000);
