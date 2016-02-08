(* Programming Languages, Assignment 3 *)
(*
   You should write your functions in this file.
   You should specify the types of your functions, both for arguments and for
   return values.
   Write your code right below the corresponding comment describing the
   function you are asked to write.
*)

(* ----------------------------------------
            ROCK PAPER SCISSORS
   ---------------------------------------- *)

(*
   In the first set of exercises we will be describing in OCAML
   the game rock-paper-scissors. If somehow you are not familiar with the
   game, read it in wikipedia.
   We will specify some custom types for the game:
   - A "shape" is one of the possible hand shapes that a player can make.
   - A "check" is a pair of the two shapes that the two players are supposed
         to have made.
   - The "result" of a check is whether it was a tie, or whether the first
         or the second player won. For instance the result of (Rock, Paper)
         should be that the second player won.
   - A "game" is a list of "checks" that are supposed to happen in order.
   - A "valid game" is a game that could actually occur: Players only continue
         to perform "checks" if they run in a tie. For instance a valid game
         would be: [(Rock, Rock), (Rock, Paper)]
         But this is not valid: [(Rock, Rock), (Rock, Paper), (Paper, Scissors)]
         because the 3rd check should not be happening.
         Also this is not valid: [(Rock, Rock), (Paper, Paper)]
         because the game cannot end with ties.
         In other words a "valid game" would consist of a sequence of tied checks
         followed by one non-tied check, and nothing after it.
   - A game, even a non-valid one, can be "played" as follows:
      - Look at each check in the list in order. Return the first result that is
            not a Tie.
      - If all checks in the game are Ties, return a Tie.
   - A "play" is a list of shapes. They represent the intended "plays" of the player.
         For example [Rock, Rock, Paper] means that the player will play Rock on
         the first check, Rock on the second check and Paper on the third check.
*)
type shape = Rock | Paper | Scissors
type check = shape * shape
type result = Tie | FstWin | SndWin
type game = check list
type play = shape list

(*
   Write a function `result` that takes as input a check and
   returns the result of that check.
   Type: check -> result
*)

let result ((chk): check) =
   match chk with
   | (Rock, Paper) -> SndWin
   | (Rock, Scissors) -> FstWin
   | (Rock, Rock) -> Tie
   | (Paper, Scissors) -> SndWin
   | (Paper, Rock) -> FstWin
   | (Paper, Paper) -> Tie
   | (Scissors, Rock) -> SndWin
   | (Scissors, Paper) -> FstWin
   | (Scissors, Scissors) -> Tie

(*
   Write a function `is_tie` that takes as input a check and returns
   whether the check's result is a tie.
   Type: check -> bool
*)

let is_tie ((chk): check) =
   result chk = Tie

(*
   Write a function `game_from_plays` that takes as input two plays (correspoding
   to the intended plays of the two players) and creates a game by combining them,
   representing how they would have been played. If one play is longer than the
   other, stop at the shortest one.
   Type: play * play -> game
*)

let rec game_from_plays ((play1, play2): play * play) =
   match (play1, play2) with
   | ([], _ :: _)
   | (_ :: _, [])
   | ([], []) -> []
   | (head1 :: tail1, head2 :: tail2) ->
      (head1, head2) :: game_from_plays(tail1, tail2)


(*
   Write a function `valid_game` that takes as input a game and determines if it is
   a valid game as described above.
   Type: game -> bool
*)

let rec valid_game ((gme): game) =
   match gme with
   | [] -> false
   | last :: [] -> not (is_tie last)
   | head :: tail ->
      if is_tie head
      then valid_game tail
      else false


(*
   Write a function `play_game` that plays the game as described above.
   Type: game -> result
*)

let play_game ((gme): game) =
   if valid_game gme
   then let rec find_last ((g): game) =
      match g with
      | last :: [] -> result last
      | head :: tail -> find_last tail
      in find_last gme
   else Tie

(* --------------------------------------
            TEMPERATURES
   -------------------------------------- *)

(*
   In this section we write functions to work flexibly with temperatures.
   A value of type "temp" is effectively a number 'tagged' with a C or F
   depending on if it is meant to be Celsius or Fahrenheit.
   The conversion between the two is the familiar formula: F = 1.8 * C + 32
*)
type temp = C of float | F of float

(*
   Write a function `to_f` that takes as input a value of type "temp" and
   returns the temperature measured in Fahrenheit.
   Note: The operators for floating point arithmetic have a dot following
   them to distinguish from the integer ones. For example "2.1 +. 5.2"
   Type: temp -> float
*)

let to_f ((tmp): temp) =
   match tmp with
   | C var1 -> 1.8 *. var1 +. 32.0
   | F var2 -> var2

(*
   Write a function `temp_compare` that takes as input a pair of temperatures and
   "compares" them, returning 1 if the first temperature is higher, 0 if they are
   equal and -1 if the second temperature is higher.
   Type: temp * temp -> int
*)

let temp_compare ((tmp1, tmp2): temp * temp) =
   if to_f tmp1 = to_f tmp2
   then 0
   else if to_f tmp1 > to_f tmp2
      then 1
      else -1

(*
   Write a function `string_of_temp` that takes as input a temperature and
   returns a string representing that temperature. For instance 23.2 Fahrenheit
   should print as "23.2F" while 23.2 Celcius as "23.2C". Look in the Pervasives
   module in the string conversions section for a function converting floats
   to strings.
   Type: temp -> string
*)

let string_of_temp ((tmp): temp) = 
   match tmp with
   | C var1 -> string_of_float var1 ^ "C"
   | F var2 -> string_of_float var2 ^ "F"

(*
   Write a function `max_temp` that takes as input a list of temperatures and
   returns the largest one. It should raise an exception `Failure "max_temp"`
   if the list is empty.
   Type: temp list -> temp
*)

let max_temp ((tmplst): temp list) = 
   match tmplst with
   | [] -> raise (Failure "max_temp")
   | head :: tail ->
      let rec max ((tmp, lst): temp * temp list) =
         match lst with
         | [] -> tmp
         | first :: rest ->
            if temp_compare (tmp, first) > -1
            then max (tmp, rest)
            else max (first, rest)
         in max (head, tail)

(*
   Write a function `max_temp2` that behaves like `max_temp` but where all the
   recursive calls are tail calls. You will likely need to define an auxiliary
   function and use state recursion.
*)

let max_temp2 ((tmplst): temp list) = max_temp tmplst
