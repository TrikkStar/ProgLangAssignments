open Types

(* You can test expressions of type resultS or resultC and how they are evaluated *)
(* These will only work once you have compiled types.ml *)

(* This is the one kind of test you can write. *)
let t0a = evaluate (NumC 2.3) = Num 2.3

(* You can also use interp directly to specify a custom environment. *)
let t0b = let env1 = bind "x" (Num 3.1) empty
          in interp env1 (NumC 2.3) = Num 2.3

(* You can also test desugar to make sure it behaves properly. *)
let t0c = desugar (NumS 2.3) = NumC 2.3

(* Or you can combine with evaluate to get to the final value. *)
let t0d = evaluate (desugar (NumS 2.3)) = Num 2.3

let t1a = evaluate (BoolC false) = Bool false
let t1b = evaluate (BoolC true) = Bool true
let t1c = desugar (BoolS false) = BoolC false
let t1d = desugar (BoolS true) = BoolC true

let t2a = evaluate (IfC (BoolC true, NumC 2.3, NumC 4.3)) = Num 2.3
let t2b = evaluate (IfC (BoolC true, (IfC (BoolC false, NumC 2.3, NumC, 7.7)), NumC 4.3)) = Num 7.7
let t2c = desugar (NotS true) = false
let t2d = desugar ()
