let rec rev ((lst): int list) =
	match lst with
	| head :: body -> rev body @ head :: []
	| [] -> []
(*inneficent needs helper function*)
