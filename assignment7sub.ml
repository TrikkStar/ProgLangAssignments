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
