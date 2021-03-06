(* Programming Languages, Assignment 7 *)
(*
   You should write your functions in this file.
   You should NOT specify the types of your functions. Let the system determine
   them for you.

   The instructions for this assignment reside in an auxiliary file, assignment7doc.md
   You should start by reading that file.
*)
(* ---------------------------------
              HELPERS
   ---------------------------------

   Place your "helpers" implementations here.
*)
let rec range a b = if a > b then [] else a :: range (a + 1) b

let range1 a = range 1 a

let tabulate func n = List.map func (range1 n)

(* ---------------------------------
              PICTURES
   ---------------------------------

   Place our Pictures implementations here after the type declarations and
   sword definition.
*)
type pixel = D | H
type row = pixel list
type pic = row list

exception IncompatibleDims

let sword = [
[D;D;D;D;D;D;D;D;D;D;D;D;D;D;D;D];
[D;H;H;D;D;D;D;D;D;D;D;D;D;D;D;D];
[D;H;H;H;H;D;D;D;D;D;D;D;D;D;D;D];
[D;D;H;H;H;H;D;D;D;D;D;D;D;D;D;D];
[D;D;H;H;H;H;H;D;D;D;D;D;D;D;D;D];
[D;D;D;H;H;H;H;D;D;D;D;D;D;D;D;D];
[D;D;D;D;H;H;H;H;D;D;D;D;D;D;D;D];
[D;D;D;D;D;D;H;H;H;D;D;D;D;D;D;D];
[D;D;D;D;D;D;D;H;H;H;D;D;H;D;D;D];
[D;D;D;D;D;D;D;D;H;H;D;H;H;D;D;D];
[D;D;D;D;D;D;D;D;D;D;H;H;D;D;D;D];
[D;D;D;D;D;D;D;D;D;H;H;H;D;D;D;D];
[D;D;D;D;D;D;D;D;H;H;D;D;H;D;D;D];
[D;D;D;D;D;D;D;D;D;D;D;D;D;H;D;D];
[D;D;D;D;D;D;D;D;D;D;D;D;D;D;H;H];
[D;D;D;D;D;D;D;D;D;D;D;D;D;D;H;H]]

(*
   You need to fix this.
*)
let doodad = [
[D;D;D;D;D;D;D];
[D;H;H;D;H;H;D];
[D;H;H;D;H;H;D];
[D;D;D;D;D;D;D];
[D;H;D;D;D;H;D];
[D;D;H;H;H;D;D];
[H;D;D;D;D;D;D]]

(*
   These two functions provided to you. Study how they work before continuing!
*)
let valid_pic pic =
   match List.map List.length pic with
   | [] -> true
   | x :: xs -> List.for_all ((=) x) xs

let dims_pic pic =
   match pic with
   | [] -> (0, 0)
   | row :: _ -> (List.length pic, List.length row)

(*
   Add your other functions here
*)

let string_of_pxl pxl =
   match pxl with
   | D -> "."
   | H -> "#"

let string_of_row row = List.fold_right (fun pxl str -> (string_of_pxl pxl) ^ str) row "\n"

let string_of_pic pic = List.fold_right (fun row str -> (string_of_row row) ^ str) pic ""

let flip_vertical pic = List.rev pic

let flip_horozontal pic = List.map (List.rev) pic

let flip_both pic = flip_horozontal (flip_vertical pic)

let mirror_vertical pic = pic @ (flip_vertical pic)

let mirror_horozontal pic = List.map (fun p -> p @ (List.rev p)) pic

let mirror_both pic = mirror_vertical (mirror_horozontal pic)

let pixelate func m n = List.fold_right (fun intX lst -> (tabulate (func intX) n) :: lst) (range1 m) []

let stack_vertical pic1 pic2 = 
   match (dims_pic pic1,  dims_pic pic2) with
   | ((_, x), (_, y)) -> 
      if x = y
      then pic1 @ pic2
      else raise IncompatibleDims

let stack_horozontal pic1 pic2 =
   match (dims_pic pic1,  dims_pic pic2) with
   | ((x, _), (y, _)) ->
      if x = y
      then List.fold_right2 (fun lst1 lst2 lst -> (lst1 @ lst2) :: lst) pic1 pic2 []
      else raise IncompatibleDims

let invert pic = List.map (fun row -> List.map (fun pxl -> if pxl = H then D else H) row) pic

let transpose pic = 
   match pic with
   | [] -> []
   | row :: rest -> List.fold_right (fun x lst -> List.map2 (fun pxl1 pxl2 -> pxl1 @ pxl2) (List.map (fun y -> y :: []) x) lst) pic (List.map (fun z -> []) row)
