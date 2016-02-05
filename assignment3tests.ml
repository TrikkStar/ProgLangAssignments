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

let t7a = temp_compare (F 2.3, F 4.5) = -1

let t8a = string_of_temp (C 2.3) = "2.3C"

let t9a = max_temp [F 2.1; C 2.1] = C 2.1

let t10a = max_temp2 [F 2.1; C 2.1] = C 2.1
