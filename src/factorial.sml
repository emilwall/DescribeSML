(* Code is based on http://www.cs.cmu.edu/~rwh/introsml/core/exceptions.htm *)
exception Factorial

fun checked_factorial n =
    let
        fun factorial 0 acc = acc
          | factorial n acc = factorial (n - 1) (n * acc)
    in 
        if n < 0 then
           raise Factorial
        else
            factorial n 1
    end
