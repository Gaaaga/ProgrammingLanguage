(* Homework3 Simple Test*)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)
use "hw3.sml";

val test1 = only_capitals ["A","B","C"] = ["A","B","C"]
val test1_1 = only_capitals ["A","ad","cda"] = ["A"]
val test1_2 = only_capitals ["A","ad","Cda"] = ["A","Cda"]
val test2 = longest_string1 ["A","bc","C"] = "bc"
val test2_1 = longest_string1 ["bc","cd"] = "bc"
val test2_2 = longest_string1 ["12312312312","bc"] = "12312312312"
val test3 = longest_string2 ["A","bc","C"] = "bc"
val test3_2 = longest_string2 ["A","bc","cd"] = "cd"

val test4a = longest_string3 ["A","bc","C"] = "bc"

val test4b = longest_string4 ["A","B","C"] = "C"

val test5 = longest_capitalized ["A","bc","C"] = "A"

val test5_1 = longest_capitalized ["qwe","a","bc","Ca","C"] = "Ca"
val test6 = rev_string "abc" = "cba"
val test7 = first_answer (fn x => if x > 3 then SOME x else NONE) [1,2,3,4,5] = 4
val test8 = all_answers (fn x => if x = 2 then SOME [x] else NONE) [2,3,4,5,6,7] = NONE
val test8_1 = all_answers (fn x => if x = 1 then SOME [x] else NONE) [] = SOME []
val test8_2 = all_answers (fn x => if x <4 then SOME [x] else NONE) [2,3] =SOME [2,3]
val test8_3 = all_answers (fn x => if x <4 then SOME [x,1] else NONE) [2,3] =SOME [2,1,3,1]
val test8_4 = all_answers (fn x => if x <4 then SOME [x] else NONE) [2,3,4] = NONE
val test9a = count_wildcards Wildcard = 1
val test9a_1 = count_wildcards(Variable("hi"))= 0
val test9a_2 = count_wildcards(TupleP([Wildcard,Wildcard,Wildcard]))= 3
val test9a_3 = count_wildcards(ConstructorP("hi",Wildcard))= 1
val test9a_4 = count_wildcards(ConstructorP("hi",Variable("hi")))= 0
val test9b = count_wild_and_variable_lengths (Variable("a")) = 1
val test9b_2 = count_wild_and_variable_lengths(TupleP([Variable("ab"),Wildcard,Wildcard]))= 4
val test9c = count_some_var ("x", Variable("x")) = 1
val test9c_1 = count_some_var ("x", ConstructorP("hi",Variable("x"))) = 1
val test9c_2 = count_some_var ("x", TupleP([Variable("x"),Variable("x"),Wildcard])) = 2
val test10 = check_pat (Variable("x")) = true
val test10_1 = check_pat (TupleP([Variable("ab"),Wildcard,Wildcard])) = true
val test10_2 = check_pat (TupleP([Variable("ab"),Variable("ab"),Wildcard])) = false
val test11_1 = match (Const(1), UnitP) = NONE
val test11_2 = match (Const(1), ConstP(1)) = SOME []
val test11_3 = match (Unit, UnitP) = SOME []
val test11_4 = match (Unit, UnitP) = SOME []
val test11_5 = match (Tuple([Const(1),Unit]), TupleP([Variable("hi"),Variable("foo")])) = SOME [("hi",Const(1)),("foo",Unit)]
val test11_6 = match (Tuple([Const(1),Unit,Unit]), TupleP([Variable("hi"),Variable("foo"),Wildcard])) = SOME [("hi",Const(1)),("foo",Unit)]
val test11_7 = match (Constructor("value",Const(1)),ConstructorP("value",Wildcard)) = SOME []
val test11_8 = match (Constructor("value",Const(1)),ConstructorP("value",Variable("hi"))) = SOME [("hi",Const(1))]
val test12 = first_match Unit [UnitP] = SOME []
val test12_1 = first_match Unit [UnitP] = SOME []
val test12_2 = first_match (Const 1) [Variable("hi")] = SOME [("hi",Const(1))]
val test12_3 = first_match (Tuple [Const(1),Unit,Unit]) [ConstP(1),TupleP([Variable("hi"),Variable("foo"),Wildcard])] = SOME [("hi",Const(1)),("foo",Unit)]

