let t1a = range 3 10 = [3; 4; 5; 6; 7; 8; 9; 10]
let t1b = range 10 3 = []

let t2a = range1 10 = [1; 2; 3; 4; 5; 6; 7; 8; 9; 10]
let t2b = range1 (-5) = []

let t4a = valid_pic doodad
let t4b = dims_pic doodad = (7, 7)

let t5a = string_of_pxl D = "*"
let t5b = string_of_pxl H = "#"