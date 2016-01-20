(* Add your own tests. Make sure to pay attention to edge cases. *)
let t1a = fixLastTwo (5, 1, 2) = (5, 1, 2)
let t1b = fixLastTwo (5, 2, 1) = (5, 1, 2)

let t2a = order (2, 5, 3) = (2, 3, 5)
let t2b = order (5, 3, 2) = (2, 3, 5)
let t2c = order (3, 2, 5) = (2, 3, 5)

let t3a = distance (6, 3) = 3
let t3b = distance (3, 6) = 3
let t3c = distance (5, 5) = 0

let t4a = greeting (23, "Pete") = "Greetings Pete, you are 23 years old!"

let t5a = greeting2 (0, "Jackson") = "Greetings Jackson, you are not born yet!"

let t6a = tooShort (4, "tree") = false

let t7a = totalLength ("you", "me") = 5

let t8a = orderedByLength ("long", "one", "at") = false

let t9a = prodInRange (3, 5) == true
