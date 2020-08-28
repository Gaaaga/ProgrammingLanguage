(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2


fun all_except_option (s, sl) = 
      case sl of
          [] => NONE
        | ys::ys' => if same_string(s,ys)
                    then SOME ys' 
                    else case all_except_option(s,ys') of
                          NONE => NONE
                        | SOME y => SOME (ys::y)

fun get_substitutions1 (stl, s) =
    case stl of
       [] => []
     | hd::tl => case all_except_option(s,hd) of
              NONE => get_substitutions1(tl,s)
            | SOME i => i @ get_substitutions1(tl,s)


fun get_substitutions2 (stl, s) =
    let fun count(tl,acc) =
      case tl of
        [] => acc
      | xs::xs' =>  case all_except_option(s,xs) of 
                        NONE => count(xs',acc)
                      | SOME i => count(xs',acc@i)
    in
    count(stl,[])
    end


fun similar_names(nl,{first:string,middle:string,last:string})=
    let fun produce(ls)=
            case ls of
              [] => []
            | hd::tl => {first=hd, last=last, middle=middle}::produce(tl)
    in
    {first=first,last=last, middle=middle }::produce(get_substitutions2(nl,first))
    end

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 
exception IllegalMove 

(* put your solutions for problem 2 here *)
fun card_color (suit , rank)=
  case suit of
    Clubs => Black
  | Spades => Black
  | Diamonds => Red
  | Hearts => Red

fun card_value (suit , rank) =
  case rank of
     Ace => 11
   | Jack => 10
   | Queen => 10
   | King => 10
   | Num i=> i

fun remove_card (cs,c,e) =
  case cs of
     [] => raise e
   | hd::tl => if hd = c then tl else hd::remove_card(tl,c,e)

fun all_same_color cs =
  case cs of
      [] => true
    | _::[] => true
    | hd::(neck::tl) => card_color(hd) = card_color(neck) andalso all_same_color(neck::tl)

fun sum_cards cs =
  let fun sum (ls,acc) =
        case ls of
          [] => acc
        | hd::tl => sum(tl,card_value(hd)+acc)
  in
    sum(cs,0)
  end

fun score (cs,goal) =
  let val sum = sum_cards(cs)
  in
    case (sum > goal,all_same_color(cs)) of
        (true,true) => 3*(sum - goal) div 2
     | (false,true) => (goal - sum) div 2
     | (true,false) => 3*(sum - goal)
     | (false,false) => goal - sum
  end

fun officiate (cards,moves,goal) =
  let fun game_on(left,attms,held) =
        case (left,attms) of
          (_,[]) => score(held,goal)
        | ([],Draw::tl') => score(held,goal)
        | (hd::tl,Draw::tl') => if sum_cards(hd::held) > goal then score(hd::held,goal) else game_on(tl,tl',hd::held)
        | (lt,Discard s::tl') => game_on(lt,tl',remove_card(held,s,IllegalMove))
  in
  game_on(cards,moves,[])
  end

fun score_challenge (cs,goal) =
  let
  val sum = sum_cards(cs)
   fun has_ace(ls)=
    case ls of
      [] => false
      | (suit,rank)::tl => if rank = Ace then true else has_ace(tl)
  in
  if sum > goal andalso has_ace(cs)
  then
    case all_same_color(cs) of
        true => (goal - (sum - 10)) div 2
     | false => goal - (sum - 10)
  else
  score(cs,goal)
  end


fun officiate_challenge (cards,moves,goal) =
  let fun game_on(left,attms,held) =
        case (left,attms,held) of
          ([],Draw::tl,_) => score_challenge(held,goal)
        | (hd::tl,Draw::tl',hand) => if sum_cards(hd::hand) > goal then score_challenge(hd::hand,goal) else game_on(tl,tl',hd::hand)
        | (lt,Discard s::tl',hand) => game_on(lt,tl',remove_card(hand,s,IllegalMove))
        | (_,[],hand) => score_challenge(hand,goal)
  in
  game_on(cards,moves,[])
  end

