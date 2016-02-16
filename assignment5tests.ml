(* CALCULATIONS *)
let t8a = has_vars (Add (Var, Int 2))
let t8b = not (has_vars (Add (Int 1, Int 2)))
let t8c = has_vars (Sub (Int 7, Var))
let t8d = has_vars (Mul (Var, Var))
let t8e = not (has_vars (Parity (Int 9)))

let t9a = count_vars (Add (Var, Int 2)) = 1
let t9b = count_vars (Add (Int 1, Int 2)) = 0
let t9c = count_vars (Mul (Var, Var)) = 2
let t9d = count_vars (Var) = 1

let t10a = calc_eval (Add (Var, Int 2), 3) = 5
let t10b = calc_eval (Sub (Var, Int 3), 7) = 4
let t10c = calc_eval (Mul (Var, Var), 5) = 25
let t10d = calc_eval (Var, 42) = 42
let t10e = calc_eval (Parity Var, 37) = 1
let t10f = calc_eval (Parity Var, (-40)) = 0

let t11a = func_of_calc (Add (Var, Int 2)) 3 = 5
let t11b = func_of_calc (Mul (Var, Var)) 5 = 25
let t11c = func_of_calc (Sub (Var, Int 1)) 7 = 6
let t11d = func_of_calc (Parity Var) 37 = 1

let t12a = subst (Add (Var, Int 1), Mul (Var, Var)) =
                Mul (Add (Var, Int 1), Add (Var, Int 1))
let t12b = subst (Add (Var, Int 1), Parity Var) = Parity (Add (Var, Int 1))
let t12c = subst (Add (Var, Int 1), Sub (Int 2, Var)) = 
				Sub (Int 2, Add (Var, Int 1))
let t12d = subst (Add (Var, Int 1), Var) = Add (Var, Int 1)
let t12e = subst (Add (Var, Int 1), Int 42) = Int 42

let t13a = power (Var, 3) = Mul (Mul (Var, Var), Var)
let t13b = power (Var, 0) = Int 1
let t13c = power (Var, 1) = Var
let t13d = power (Var, 6) = Mul (Mul (Mul (Mul (Mul (Var, Var), Var), Var), Var), Var)
let t13e = power (Int 7, 7) = Mul (Mul (Mul (Mul (Mul (Mul (Int 7, Int 7), Int 7), Int 7), Int 7), Int 7), Int 7)

let t14a = term (2, 1) = Mul(Int 2, Var)

let t15a = poly [(2, 1); (1, 4)] = Add (term (2, 1), term (1, 4))
let t15b = poly [(2, 1); (0, 2); (1, 4)] = Add (term (2, 1), term (1, 4))
let t15c = poly [(0, 1); (0, 4)] = Int 0
let t15d = poly [(0, 1)] = Int 0
let t15e = poly [] = Int 0
let t15f = poly [(2, 1); (0, 1)] = term (2, 1)
let t15g = poly [(0, 1); (2, 1)] = term (2, 1)

let t16a = simplify (Add (Int 0, Var)) = Var
let t16b = simplify (Add (Int 3, Int 4)) = Int 7
let t16c = calc_eval (simplify (poly [(2, 1); (1, 0)]), 3) = 7
