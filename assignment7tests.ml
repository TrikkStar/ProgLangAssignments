let t1a = range 3 10 = [3; 4; 5; 6; 7; 8; 9; 10]
let t1b = range 10 3 = []

let t2a = range1 10 = [1; 2; 3; 4; 5; 6; 7; 8; 9; 10]
let t2b = range1 (-5) = []

let t3a = tabulate (fun x -> x *2) 5 = [2; 4; 6; 8; 10]

let t4a = valid_pic doodad
let t4b = dims_pic doodad = (7, 7)

let t5a = string_of_pxl D = "."
let t5b = string_of_pxl H = "#"

let t6a = string_of_row [D;D;D;D;D;D;D] = ".......\n"
let t6b = string_of_row [H;H;H;H;H;H;H] = "#######\n"
let t6c = string_of_row [D;D;H;D;H;D;D] = "..#.#..\n"

let t7a = string_of_pic doodad = ".......\n.##.##.\n.##.##.\n.......\n.#...#.\n..###..\n#......\n"
let t7b = print_string (string_of_pic sword)

let t8a = string_of_pic (flip_vertical doodad) = "#......\n..###..\n.#...#.\n.......\n.##.##.\n.##.##.\n.......\n"
let t8b = print_string(string_of_pic (flip_vertical sword))

let t9a = string_of_pic (flip_horozontal doodad) = ".......\n.##.##.\n.##.##.\n.......\n.#...#.\n..###..\n......#\n"
let t9b = print_string (string_of_pic (flip_horozontal sword))

let t10a = string_of_pic (flip_both doodad) = "......#\n..###..\n.#...#.\n.......\n.##.##.\n.##.##.\n.......\n"
let t10b = print_string (string_of_pic (flip_both sword))

let t11a = dims_pic (mirror_vertical doodad) = (14, 7)
let t11b = string_of_pic (mirror_vertical doodad) = ".......\n.##.##.\n.##.##.\n.......\n.#...#.\n..###..\n#......\n#......\n..###..\n.#...#.\n.......\n.##.##.\n.##.##.\n.......\n"
let t11c = print_string (string_of_pic (mirror_vertical sword))

let t12a = dims_pic (mirror_horozontal doodad) = (7, 14)
let t12b = string_of_pic (mirror_horozontal doodad) = "..............\n.##.##..##.##.\n.##.##..##.##.\n..............\n.#...#..#...#.\n..###....###..\n#............#\n"
let t12c = print_string (string_of_pic (mirror_horozontal sword))

let t13a = dims_pic (mirror_both doodad) = (14, 14)
let t13b = string_of_pic (mirror_both doodad) = "..............\n.##.##..##.##.\n.##.##..##.##.\n..............\n.#...#..#...#.\n..###....###..\n#............#\n#............#\n..###....###..\n.#...#..#...#.\n..............\n.##.##..##.##.\n.##.##..##.##.\n..............\n"
let t13c = print_string (string_of_pic (mirror_both sword))

let toPixel a b = if a mod b = 0
				then H
				else D
let t14a = dims_pic (pixelate (toPixel) 3 5) = (3, 5)
let t14b = string_of_pic (pixelate (toPixel) 3 5)

let t15a = dims_pic(stack_vertical doodad doodad) = (14, 7)
let t15b = string_of_pic (stack_vertical doodad doodad) = ".......\n.##.##.\n.##.##.\n.......\n.#...#.\n..###..\n#......\n.......\n.##.##.\n.##.##.\n.......\n.#...#.\n..###..\n#......\n"
(*let t15c = try (stack_vertical doodad sword) with
			| exception -> true
			| _ -> false*)
let t15d = print_string (string_of_pic (stack_vertical sword sword))

let t16a = dims_pic(stack_horozontal doodad doodad) = (7, 14)
let t16b = string_of_pic (stack_horozontal doodad doodad) = "..............\n.##.##..##.##.\n.##.##..##.##.\n..............\n.#...#..#...#.\n..###....###..\n#......#......\n"
let t16c = print_string (string_of_pic (stack_horozontal sword sword))

let t17a = dims_pic (invert doodad) = dims_pic doodad
let t17b = string_of_pic (invert doodad) = "#######\n#..#..#\n#..#..#\n#######\n#.###.#\n##...##\n.######\n"
let t17c = print_string (string_of_pic (invert doodad))
