let rec sq ((lst): int list) = 
	match lst with 
	| l1 :: lstx -> l1*l1 :: sq lstx 
	| [] -> lst

let hd ((lst): int list) = 
	match lst with
	| l1 :: _ -> l1
	| [] -> raise (Failure "hd")

let tl ((lst): int list) = 
	match lst with
	| _ :: tail -> l1
	| [] -> raise (Failure "tl")

let rec any ((lst): bool list) = 
	match lst with
	| l1 :: rest -> 
	 if l1=true 
	 then true
	 else any rest
	| [] -> false

let rec all ((lst): bool list) = 
	match lst with 
	| l1 :: rest -> 
	 if l1<>true 
	 then false 
	 else all rest 
	| [] -> true