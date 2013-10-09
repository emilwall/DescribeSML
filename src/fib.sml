local
    fun fib' i n prev1 prev2 =
        if i = n then
            [prev1 + prev2]
        else
            (prev1 + prev2) :: fib' (i + 1) n prev2 (prev1 + prev2)
in
    fun fib n =
        if n < 1
        then []
        else if n = 1
        then [1]
        else 1 :: fib' 1 (n - 1) 0 1
end