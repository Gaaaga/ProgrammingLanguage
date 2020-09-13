(* Homework2 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)
use "hw2.sml";

val test1 = all_except_option ("string", ["string"]) = SOME []
val test1_1 = all_except_option ("string", ["string","foo"]) = SOME ["foo"]
val test1_2 = all_except_option ("string", ["foo"]) = NONE
val test1_3 = all_except_option ("string", ["foo","string","there"]) = SOME ["foo","there"]
val test2 = get_substitutions1 ([["foo"],["there"]], "foo") = []
val test2_1 = get_substitutions1 ([["foo"],["there","foo"]], "foo") = ["there"]
val test2_2 = get_substitutions1 ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Fred") = ["Fredrick","Freddie","F"]

val test3 = get_substitutions2 ([["foo"],["there"]], "foo") = []
val test3_1 = get_substitutions2 ([["foo"],["here","foo"],["there","foo"]], "foo") = ["here","there"]
val test3_2 = get_substitutions2 ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Fred") = ["Fredrick","Freddie","F"]
val test4 = similar_names ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"}) =
      [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", last="Smith", middle="W"},
	     {first="Freddie", last="Smith", middle="W"}, {first="F", last="Smith", middle="W"}]
val test5 = card_color (Clubs, Num 2) = Black

val test6 = card_value (Clubs, Num 2) = 2
val test7 = remove_card ([(Hearts, Ace)], (Hearts, Ace), IllegalMove) = []
val test7_1 = remove_card ([(Spades, Jack),(Hearts, Ace),(Hearts, Jack)], (Hearts, Ace), IllegalMove) = [(Spades, Jack),(Hearts, Jack)]
val test7_2 = remove_card ([(Spades, Jack),(Hearts, Ace),(Hearts, Jack),(Hearts, Ace)], (Hearts, Ace), IllegalMove) = [(Spades, Jack),(Hearts, Jack),(Hearts, Ace)]

val test8 = all_same_color [(Hearts, Ace), (Hearts, Ace)] = true
val test8_1 = all_same_color [(Hearts, Ace), (Hearts, Num 9),(Clubs, Num 4)] = false
val test8_2 = all_same_color [(Hearts, Ace), (Clubs, Ace)] = false
val test8_3 = all_same_color [(Hearts, Ace), (Clubs, Num 4),(Hearts, Num 9)] = false
val test9 = sum_cards [(Clubs, Num 2),(Clubs, Num 2)] = 4
val test10 = score ([(Hearts, Num 2),(Clubs, Num 4)],10) = 4
val test10_1 = score ([(Hearts, Num 2),(Hearts, Num 9)],10) = 1
val test10_2 = score ([(Hearts, Num 2),(Hearts, Num 9),(Clubs, Num 4)],10) = 15
val test10_3 = score ([(Hearts, Num 2),(Hearts, Num 9),(Clubs, Num 4)],15) = 0
val test10_4 = score ([(Hearts, Num 2),(Hearts, Num 9),(Clubs, Num 4)],16) = 1
val test10_5 = score ([(Hearts, Num 2),(Hearts, Num 9),(Hearts, Num 4)],16) = 0
val test11 = officiate ([(Hearts, Num 2),(Clubs, Num 4)],[Draw], 15) = 6
val test12 = officiate ([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                        [Draw,Draw,Draw,Draw,Draw],
                        42)
             = 3
val test13 = ((officiate([(Clubs,Jack),(Spades,Num(8))],
                         [Draw,Discard(Hearts,Jack)],
                         42);
               false) 
              handle IllegalMove => true)
             
val test14_1 = score ([(Hearts, Num 2),(Hearts, Num 9)],10) = 1
val test14_2 = score ([(Hearts, Num 2),(Hearts, Num 9),(Clubs, Num 4)],10) = 15
val test14_3 = score ([(Hearts, Num 2),(Hearts, Num 9),(Clubs, Num 4)],15) = 0
val test14_4 = score ([(Hearts, Num 2),(Hearts, Num 9),(Clubs, Num 4)],16) = 1
val test14_5 = score ([(Hearts, Num 2),(Hearts, Num 9),(Hearts, Num 4)],16) = 0
val test14_6 = score_challenge ([(Hearts, Num 2),(Hearts, Num 9),(Hearts, Num 4),(Clubs, Ace)],16) = 0
val test14_7 = score_challenge ([(Hearts, Num 2),(Hearts, Num 9),(Hearts, Num 4),(Hearts, Ace)],18) = 1
val test15 = officiate_challenge ([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Hearts,Ace)],
                        [Draw,Draw,Draw,Draw,Draw],
                        34)
             = 0
val test16_1 = careful_player([(Clubs,Num 1),(Spades,Num 2),(Hearts,Num 3),(Hearts,Jack)],13) = [Draw,Draw,Draw,Discard (Hearts,Num 3),Draw]
val test16_2 = careful_player([(Clubs,Num 1),(Spades,Num 2),(Hearts,Num 3),(Hearts,Jack)],14) = [Draw,Draw,Draw,Discard (Spades,Num 2),Draw]
val test16_3 = careful_player([(Clubs,Num 1),(Spades,Num 2),(Hearts,Num 3),(Hearts,Jack)],18) = [Draw,Draw,Draw,Draw]
