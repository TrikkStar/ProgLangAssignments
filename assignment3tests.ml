let t1a = result (Rock, Paper) = SndWin
let t1b = result (Rock, Scissors) = FstWin
let t1c = result (Rock, Rock) = Tie

let t2a = is_tie (Rock, Paper) = false
let t2b = is_tie (Scissors, Scissors) = true

let t3a = game_from_plays ([Rock; Paper; Rock], [Scissors; Rock; Rock]) =
               [(Rock, Scissors); (Paper, Rock); (Rock, Rock)]
let t3b = game_from_plays ([Rock; Paper;], [Scissors; Rock; Rock]) =
               [(Rock, Scissors); (Paper, Rock)]

let t4a = valid_game [(Rock, Scissors)] = true
let t4b = valid_game [(Rock, Scissors); (Paper, Rock)] = false
let t4c = valid_game [(Rock, Rock); (Paper, Paper); (Scissors, Scissors); (Paper, Rock)] = true

let t5a = play_game [(Rock, Rock); (Scissors, Rock)] = SndWin
let t5b = play_game [(Rock, Rock); (Paper, Paper); (Scissors, Scissors); (Paper, Rock)] = FstWin
let t5c = play_game [(Rock, Rock); (Paper, Paper); (Scissors, Scissors)] = Tie

let t6a = to_f (F 2.3) = 2.3
let t6b = to_f (C 0.0) = 32.0
let t6c = to_f (C 100.0) = 212.0

let t7a = temp_compare (F 2.3, F 4.5) = -1
let t7b = temp_compare (C 100.0, F 212.0) = 0
let t7c = temp_compare (C 0.0, F 0.0) = 1

let t8a = string_of_temp (C 2.3) = "2.3C"
let t8b = string_of_temp (F 98.6) = "98.6F"

let t9a = max_temp [F 2.1; C 2.1] = C 2.1
let t9b = max_temp [F 2.1; C 2.1; F 98.6; C 100.0; F 145.3] = C 100.0
let t9c = max_temp [C 212.0; F 2.1; C 2.1; F 212.0; F 98.6; C 100.0; F 145.3] = C 212.0
let t9d = try (max_temp []; false)  with
            | Failure "max_temp" -> true
            | _ -> false

let t10a = max_temp2 [F 2.1; C 2.1] = C 2.1
let t10b = max_temp2 [F 2.1; C 2.1; F 98.6; C 100.0; F 145.3] = C 100.0
let t10c = try (max_temp2 []; false)  with
            | Failure "max_temp2" -> true
            | _ -> false