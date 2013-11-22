structure Stopwatch :>
sig
    val time : (unit -> 'a) -> int
end =
struct
    fun time callback =
        let
            val timer = Timer.startCPUTimer()
            val elapsed = (callback(); Timer.checkCPUTimer timer)
        in
            (Int.fromLarge o Time.toMicroseconds o #usr) elapsed
        end
end
