let t1a = getnth (3, ["hi"; "there"; "you"]) = "you"
let t1b = getnth (1, ["hi"; "there"; "you"]) = "hi"
let t1c = try (getnth (3, ["hi"; "there"]); false)  with
            | Failure "getnth" -> true
            | _ -> false
let t1d = try (getnth (0, ["hi"; "there"]); false)  with
            | Failure "getnth" -> true
            | _ -> false

let t2a = lookup ("you", []) = None
let t2b = lookup ("you", [("him", 2); ("you", 3)]) = Some 3
let t2c = lookup ("", [("him", 2); ("you", 3); ("string", 53); ("", 42)]) = Some 42

let t3a = inPairs [1; 2; 3; 4; 5] = [(1, 2); (3, 4)]
let t3b = inPairs [1; 2; 3; 4; 5; 6] = [(1, 2); (3, 4); (5, 6)]
let t3c = inPairs [1] = []

let t4a = flatten [[1; 2; 3]; []; [4; 5]; [6]] = [1; 2; 3; 4; 5; 6]
let t4b = flatten [[]; [];] = []

let t5a = remove (3, [3; 4; 3; 1]) = [4; 1]
let t5b = remove (3, [3; 3; 3; 3]) = []
let t5c = remove (3, [2; 4; 5; 1]) = [2; 4; 5; 1]

let t6a = removeDups [4; 1; 2; 1; 4; 5; 20] = [4; 1; 2; 5; 20]
let t6b = removeDups [3; 3; 3; 3] = [3]
let t6c = removeDups [3; 4; 5; 6] = [3; 4; 5; 6]

let t7a = collateSome [Some 1; None; Some 2; Some 1; None; Some 3] = [1; 2; 1; 3]
<<<<<<< HEAD
let t7b = collateSome [None; None; None;] = []
=======
>>>>>>> refs/remotes/skiadas/master

let t8a = unzip2 [(1, 2); (3, 4); (5, 6)] = ([1; 3; 5], [2; 4; 6])
let t8b = unzip2 [(1, 2)] = ([1], [2])
let t8c = unzip2 [] = ([], [])

let t9a = makeChange (20, [8; 3; 2]) = Some [8; 8; 2; 2]
let t9b = makeChange (20, [8; 3]) = Some [8; 3; 3; 3; 3]
let t9c = makeChange (20, [13; 11]) = None
let t9d = makeChange (20, [19; 2]) = Some [2; 2; 2; 2; 2; 2; 2; 2; 2; 2]
let t9e = makeChange (20, [11; 6; 5; 2; 1]) = Some [11; 6; 2; 1]
