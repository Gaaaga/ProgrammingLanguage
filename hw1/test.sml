use "hw1.sml";
(* Homework1 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)


val test1 = is_older ((1,2,3),(2,3,4)) = true
val test12 = is_older ((1,2,3),(1,2,4)) = true
val test13 = is_older ((2,2,3),(1,2,4)) = false
val test2 = number_in_month ([(2012,2,28),(2013,12,1)],2) = 1
val test3 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = 3
val test31 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,2,3,4]) = 4
val test32 = number_in_months([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28),(2011,4,23),(2011,5,23)],[1,2,4,3,4]) = 6

val test4 = dates_in_month ([(2012,2,28),(2013,12,1)],2) = [(2012,2,28)]
val test5 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)]
val test51 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4,4]) = [(2012,2,28),(2011,3,31),(2011,4,28),(2011,4,28)]
val test6 = get_nth (["hi", "there", "how", "are", "you"], 2) = "there"
val test61 = get_nth (["hi", "there", "how", "are", "you"], 1) = "hi"
val test7 = date_to_string (2013, 6, 1) = "June 1, 2013"
val test8 = number_before_reaching_sum (10, [1,2,3,4,5]) = 3
val test81 = number_before_reaching_sum (2, [1,2,3,4,5]) = 1
val test9 = what_month 60 = 3
val test91 = what_month 90 = 3
val test92 = what_month 91 = 4
val test10 = month_range (31, 34) = [1,2,2,2]
val test11 = oldest([(2012,2,28),(2011,3,31),(2011,4,28)]) = SOME (2011,3,31) 
val test111 = number_in_months_challenge([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,2,3,4]) = 3
val test112 = number_in_months_challenge([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28),(2011,4,23),(2011,5,23)],[1,2,4,3,4]) = 4
val test121 = dates_in_months_challenge([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)]
val test131 = reasonable_date(2012,2,29)=true
val test132 = reasonable_date(2014,2,29)=false
val test133 = reasonable_date(2014,4,30)=true
