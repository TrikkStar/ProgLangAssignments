(* Programming Languages, Assignment 5 *)
(*
   You should write your functions in this file.
   You should NOT specify the types of your functions. Let the system determine
   them for you.

   Write your code right below the corresponding comment describing the
   function you are asked to write.
*)


(* ----------------------------------------
               CALCULATIONS
   ---------------------------------------- *)

(*
   In this section we will build an OCAML type that represents basic calculations.
   We will call our type "calc". A "calculation" is expected to return an integer
   value, and it can expect to be given a value for the parameter x.

   A value of type `calc` can be one of the following variants:
   - `Var`, indicating that this is meant to be a variable (like the
   x in an equation). We will assume there is only one possible variable, namely x.
   - `Int i` where i is an integer.
   - `Add (c1, c2)` where `c1` and `c2` are themselves of type `calc`. It represents
   the idea of calculating c1 and c2, then adding the results.
   - `Sub (c1, c2)` where `c1` and `c2` are themselves of type `calc`. It represents
   the idea of calculating c1 and c2, then subtracting the results.
   - `Mul (c1, c2)` where `c1` and `c2` are themselves of type `calc`. It represents
   the idea of calculating c1 and c2, then multiplying the results.
   - `Parity c1`, where `c1` is of type `calc`. It represents the calculation where
   we compute `c1` and then return `1` if the result is odd, `0` if the result is even.
   Make sure this works properly for negative numbers as well.

   The following type defines this:
*)
type calc = Var
          | Int of int
          | Add of calc * calc
          | Sub of calc * calc
          | Mul of calc * calc
          | Parity of calc

(*
   Write a function `has_vars` that takes as input a calculation and returns a
   boolean indicating whether the calculation has a reference to the variable in
   it. Do NOT use the `count_vars` that follows.
   It should have type calc -> bool
*)

let has_vars clc = 
   match clc with
   | Add (Var, _)
   | Add (_, Var)
   | Sub (Var, _)
   | Sub (_, Var)
   | Mul (Var, _)
   | Mul (_, Var)
   | Parity (Var)
   | Var -> true
   | _ -> false

(*
   Write a function `count_vars` that takes as input a calculation and returns the
   number of references to the variable in that calculation. Do NOT use `has_vars`.
   It should have type: calc -> int
*)

let count_vars clc =
   match clc with
   | Add (Var, Var) | Sub (Var, Var) | Mul (Var, Var) -> 2
   | Add (Var, _) | Add (_, Var) | Sub (Var, _) | Sub (_, Var)
   | Mul (Var, _) | Mul (_, Var) | Parity (Var) | Var -> 1
   | _ -> 0

(*
   Write a function `calc_eval` that takes as input a pair of a calculation and an
   integer x, and proceeds to "evaluate" the calculation according to the meanings
   described above.
   It should have type: calc * int -> int
*)

let rec calc_eval (clc, intX) =
   match clc with
   | Var -> intX
   | Int y -> y
   | Add (a, b) -> calc_eval (a, intX) + calc_eval (b, intX)
   | Sub (a, b) -> calc_eval (a, intX) - calc_eval (b, intX)
   | Mul (a, b) -> calc_eval (a, intX) * calc_eval (b, intX)
   | Parity (valX) -> abs (calc_eval (valX, intX)) mod 2


(*
   Write a function `func_of_calc` that takes as input a calculation and returns
   a function `int -> int` that given an integer would evaluate that calculation
   using that integer as the variable's value. This is relatively easy, your
   answer will be short.
   It should have type: calc -> (int -> int)
   (though the parentheses will not show)
*)

let func_of_calc clc = fun intX -> calc_eval (clc, intX)

(*
   Write a function `subst` that takes as input a pair of calculations (c1, c2)
   and returns the calculation that results if we substitute every instance of
   the variable in c2 with c1.
   It should have type: calc * calc -> calc
*)

let subst (clc1, clc2) =
   match clc2 with
   | Add (Var, Var) -> Add (clc1, clc1)
   | Sub (Var, Var) -> Sub (clc1, clc1)
   | Mul (Var, Var) -> Mul (clc1, clc1)
   | Add (Var, x) -> Add (clc1, x)
   | Add (x, Var) -> Add (x, clc1)
   | Sub (Var, x) -> Sub (clc1, x)
   | Sub (x, Var) -> Sub (x, clc1)
   | Mul (Var, x) -> Mul (clc1, x)
   | Mul (x, Var) -> Mul (x, clc1)
   | Parity Var -> Parity clc1
   | Var -> clc1
   | _ -> clc2

(*
   Write a function `power` that takes as input a pair of a calculation and an
   integer n, and returns the calculation that amounts to computing the n-th power
   of the calculation, i.e. the product of n copies of the calculation, where
   you must ensure the multiplications occur in a left-associative way. For example
   `power (Var, 3)` should produce `Mul (Mul(Var, Var), Var)`.
   You can assume the integer is non-negative, but your code should properly handle
   the special cases of n = 0, when the result should be the calculation o7f 1, and
   n = 1, when the result should be the calculation itself.
   It should have type: calc * int -> calc
*)

let rec power (clc, n) =
   match n with
   | 0 -> Int 1
   | 1 -> clc
   | 2 -> Mul (clc, clc)
   | x -> Mul (power (clc, (x - 1)), clc)

(*
   Write a function `term` that takes as input a pair of integers `(a, n)` and
   returns the calculation representing the "term" `a * x^n` ("a" times the
   variable raised to the n-th power).
   Your code should take special care of the following cases, that all have
   simpler answers:
   - When the coefficient "a" is 0.
   - When the exponent is 0.
   - When the coefficient "a" is 1.
   It should have type: int * int -> calc
*)

let term (a, n) =
   match (a, n) with
   | (0, _) -> Int 0
   | (1, _) | (_, 0) -> Int 1
   | (x, y) -> Mul (Int a, power (Var, n))

(*
   Write a function `poly` that takes as input a list of pairs of integers
   representing terms as in the previous function, and returns the "polynomial"
   that results from adding these terms. For example `poly [(2, 3), (1, 1), (3, 0)]`
   should result in the calculation representing "2x^3 + x + 3".
   Special cases:
   - The empty list should result in the integer 0.
   - A non-empty list should NOT have an extra "+0" at the end. You will need to
   stop the recursion at a one-element list.
   - If a "term" has zero coefficient, it should be skipped. But if all terms have
   zero coefficient you should still be getting a "Int 0". The cleanest way to
   ensure this behavior is to "remove a term with a zero coefficient if it is not
   the first term in the list, or if it is the first term but followed by a
   non-zero term".
   You can do this problem with recursion and a single pattern match with about 6
   cases.
   It should have type: (int * int) list -> calc
*)

let rec poly lst =
   match lst with
   | [] -> Int 0
   | (a, n) :: (0, _) :: [] -> term (a, n)
   | (a, n) :: [] -> term (a, n)
   | (0, n) :: rest -> poly rest
   | (a, n) :: rest -> Add (term (a, n), poly rest)

(*
   This is a difficult problem, with many objectives. Do as much of it as you can.
   Some of the later objectives are harder.
   The goal is to write a function `simplify` that will take a calculation and it
   will carry out as many simplifications as possible.
   It should have type `calc -> calc`
   We list below the simplifications that your code should do. You can capture a
   lot of these as cases in a big match-with block. As an example, the overall
   structure of the function is shown and one case is handled, that of the addition
   of two calculations: We recursively simplify the two subcalculations. We need to
   be a bit careful because the simplifications of the subcalculations might have
   enabled more simplifications at the higher level. Therefore the end of the code
   checks to see if the result of a simplification step is identical to what we
   started, and if it is not then tries to simplify it.
   Your code should catch other more special "addition patterns" before the generic
   one.
   Here is a list of the kinds of simplifications your code should perform. In
   general your code should try to perform these in the order presented here.
   - Your code should always ensure that it tries to simplify the subparts when
   possible, if no top-level simplification is possible.
   - If there is ever an addition of two integers, it should be replaced by the
   result of performing that addition. E.g. `Add (Int 1, Int 2)` replaced by `Int 3`.
   - Same for multiplication or subtraction between two integers, as well as
   taking the parity of some integer.
   - Addition of a 0, on the left or on the right, should be replaced by the
   corresponding term (i.e. `0 + c` should be replaced by `c`). Same for
   subtracting of 0  (c - 0 = c).
   - Similarly multiplication by 1 should be performed.
   - Multiplication by 0 should be simplified to 0.
   - Subtraction where the second part is an integer should become addition with
   the negative of that integer.
   - If in an addition the second term is an integer but the first is not,
   they should swap places. Same for multiplication.
   - If an addition has as its second term another addition, this should turn into
   the corresponding left-associative addition. i.e. `a+(b+c)` should turn into
   `(a+b)+c`.
   - If a multiplication has as its second term another multiplication, this should
   turn into a corresponding left-associative multiplication. i.e. `a*(b*c)` should
   turn into `(a*b)*c`.
   - You should detect expressions of the form `(a*b) + (a*c)` and replace them with
   `a*(b+c)`. Same with `(b*a) + (c*a)` replaced by `(b+c)*a`.
   - You should detect expressions of the form `a + a` and replace them with `2*a`.
   - Similarly subtractions `a - a` should become 0.
   - You should detect expressions of any of the four forms
   `b*a + a`, `a*b + a`, `a + b*a`, `a + a*b` and factor out the common factor.
   Make sure to preserve the order of terms on this step.

*)

let rec simplify c =
   let c' =
      match c with
      | Var -> Var        
      | Int i -> Int i      
      | Add (Int x, Int y) -> Int (x + y)
      | Add (Int 0, x) | Add (x, Int 0) | Sub (x, Int 0) -> x
      | Mul (Int 1, x) | Mul (x, Int 1) -> x
      | Mul (Int 0, _) | Mul (_, Int 0) -> Int 0
      | Sub (x, Int y) -> Add (x, Int (-y))
      | Add (x, Int y) -> Add (Int y, x)
      | Mul (Var, Int x) -> Mul (Int x, Var)
      | Mul (Add (c1, c2), Int y) -> Mul (Int y, Add (c1, c2))
      | Mul (Sub (c1, c2), Int y) -> Mul (Int y, Sub (c1, c2))
      | Mul (Mul (c1, c2), Int y) -> Mul (Int y, Mul (c1, c2))
      | Mul (Parity x, Int y) -> Mul (Int y, Parity x)
      | Add (x, Add (y, z)) -> Add (Add (x, y), z)
      | Mul (x, Mul (y, z)) -> Mul (Mul (x, y), z)
      | Add (Mul (a, b), Mul (a', c)) -> 
         if a = a'
         then Mul (a, Add (b, c))
         else if b = c
            then Mul (Add (a, a'), b)
            else Add (Mul (a, b), Mul (a', c))
      | Add (Mul (a, b), c) ->
         if b = c
         then Mul ( Add (a, Int 1), b)
         else if a = c
            then Mul ( Add (b, Int 1), a)
            else Add (Mul (a, b), c)
      | Add (a, Mul (b, c)) ->
         if a = c
         then Mul ( Add (b, Int 1), c)
         else if a = b
            then Mul ( Add (c, Int 1), a)
            else Add (a, Mul (b, c))
      | Add (c1, c2) -> 
         if c1 = c2
         then Mul (Int 2, c1)
         else Add (simplify c1, simplify c2)
      | Sub (c1, c2) -> 
         if c1 = c2
         then Int 0
         else Sub (simplify c1, simplify c2)
      | Mul (c1, c2) -> Mul (simplify c1, simplify c2)
      | Parity c1 -> Parity (simplify c1)
   in if c' = c then c' else simplify c'
