let t1a = range 3 10 = [3; 4; 5; 6; 7; 8; 9; 10]
let t1b = range 10 3 = []

let t2a = range1 10 = [1; 2; 3; 4; 5; 6; 7; 8; 9; 10]
let t2b = range1 (-5) = []

let t4a = valid_pic doodad
let t4b = dims_pic doodad = (7, 7)

let t5a = string_of_pxl D = "."
let t5b = string_of_pxl H = "#"

let t6a = string_of_row [D;D;D;D;D;D;D] = ".......\n"
let t6b = string_of_row [H;H;H;H;H;H;H] = "#######\n"
let t6c = string_of_row [D;D;H;D;H;D;D] = "..#.#..\n"

let t7a = string_of_pic doodad = ".......\n.##.##.\n.##.##.\n.......\n.#...#.\n..###..\n#......\n"
let t7b = print_string (string_of_pic sword)
