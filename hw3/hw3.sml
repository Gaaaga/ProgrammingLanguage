(* Coursera Programming Languages, Homework 3, Provided Code *)

fun only_capitals(strings) = 
    List.filter (fn (str)=>Char.isUpper(String.sub(str,0)))(strings)

fun longest_string1(strings) =
case strings of
   [] => ""   
 | hd::tl => foldl (fn (hd,acc)=> if String.size(hd) > String.size(acc) then hd else acc) "" strings

fun longest_string2(strings) =
case strings of
   [] => ""   
 | hd::tl => foldl (fn (hd,acc)=> if String.size(hd) >= String.size(acc) then hd else acc) "" strings

fun longest_string_helper f strings = 
case strings of
   [] => ""
 | hd::tl => foldl (fn (hd,acc)=> if f(size hd,size acc) then hd else acc) "" strings

val longest_string3 = longest_string_helper (fn (x,y)=>x > y)
val longest_string4 = longest_string_helper (fn (x,y)=>x >= y)

val longest_capitalized = longest_string1 o only_capitals

val rev_string = String.implode o List.rev o String.explode

exception NoAnswer

fun first_answer f list =
  case list of
     [] => raise NoAnswer
   | hd::tl =>  case f(hd) of
                NONE => first_answer f tl
              | SOME i => i

 (* (’a -> ’b list option) -> ’a list -> ’b list option *)
fun all_answers f list = 
    let fun helper(lst,acc) =
      case lst of
      [] => SOME acc
      | hd::tl => case f(hd) of
                NONE => NONE
              | SOME i => helper(tl,acc@i)
    in
    helper(list,[])
    end


datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

val count_wildcards = g (fn _=>1) (fn _=>0)

val count_wild_and_variable_lengths =  g (fn _=>1) String.size

fun count_some_var (s,p) = g (fn _=>0) (fn (x) => if x=s then 1 else 0) p

fun check_pat pat = 
    let
      fun all_var p =
        case p of
          Variable x        => [x]
        | TupleP ps         => List.foldl (fn (pt,i) => all_var pt@i ) [] ps
        | ConstructorP(_,p) => all_var p
        | _                 => []
      fun is_exists strs = 
        case strs of
           [] => true
         | hd::tl => if List.exists (fn (x)=>x=hd) tl then false else is_exists(tl)
    in
       (is_exists o all_var) pat
    end

(* val match = fn : valu * pattern -> (string * valu) list option *)
fun match (value,pat) =
  case (value,pat) of
     (_,Wildcard) => SOME []
   | (_,Variable s) => SOME [(s,value)]
   | (Unit,UnitP) => SOME []
   | (Const i2,ConstP i1) => if i1=i2 then SOME [] else NONE
   | (Tuple vs,TupleP ps) => if length ps = length vs then all_answers match (ListPair.zip(vs,ps)) else NONE
   | (Constructor(s1,v),ConstructorP(s2,p)) => if s1 = s2 then match(v,p) else NONE
   | (_,_) => NONE

(* : valu -> pattern list -> (string * valu) list option *)
fun first_match v ps = SOME ( (first_answer (fn (p)=>match(v,p)) ps) ) handle NoAnswer => NONE



(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)

