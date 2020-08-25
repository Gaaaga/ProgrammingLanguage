(* val is_older = fn : (int * int * int) * (int * int * int) -> bool *)
fun is_older (date1:int*int*int, date2: int*int*int)=
    if #1 date1 < #1 date2
    then true
    else if #1 date1> #1 date2
        then false
        else if #2 date1 < #2 date2
            then true
            else if #2 date1> #2 date2
                then false
                else if #3 date1 < #3 date2
                    then true
                    else false

(* val number_in_month = fn : (int * int * int) list * int -> int *)
fun number_in_month (list: (int*int*int) list, month: int) =
    if null list 
    then 0
    else
    let val count = number_in_month(tl list,month)
    in
        if #2 (hd list)=  month
        then 1+count
        else count
    end
(* val number_in_months = fn : (int * int * int) list * int list -> int *)
fun number_in_months (ds: (int*int*int) list,ms: int list)=
    if null ms
    then 0
    else number_in_month(ds,hd ms)+number_in_months(ds, tl ms)


(* val dates_in_month = fn : (int * int * int) list * int -> (int * int * int) list *)
fun dates_in_month (list: (int*int*int) list, month: int) =
    if null list
    then []
    else
        let val dates = dates_in_month(tl list, month)
        in
            if #2 (hd list)=  month
            then hd list:: dates
            else dates
        end



(* val dates_in_months = fn : (int * int * int) list * int list -> (int * int * int) list *)
fun dates_in_months(ds:(int * int * int) list, ms: int list)=
    if null ms
    then []
    else
        dates_in_month(ds, hd ms)@dates_in_months(ds,tl ms)


(* val get_nth = fn : string list * int -> string *)
fun get_nth(ls:string list,n:int)=
    if null ls 
    then ""
    else if n = 1
        then hd ls
        else get_nth(tl ls, n-1)
        
(* val date_to_string = fn : int * int * int -> string *)
fun date_to_string(date: int * int * int) =
    let val months = ["January", "February", "March", "April",
"May", "June", "July", "August", "September", "October", "November", "December"]
    in
        get_nth(months,#2 date)^" "^Int.toString(#3 date)^", "^Int.toString(#1 date)
    end

(* val number_before_reaching_sum = fn : int * int list -> int *)
fun number_before_reaching_sum(sum: int, ls: int list)=
    if sum > hd ls
    then 1+number_before_reaching_sum(sum - hd ls, tl ls)
    else 0
    

(* val what_month = fn : int -> int *)
fun what_month(int)=
    let val month = [31,28,31,30,31,30,31,31,30,31,30,31]
    in
        number_before_reaching_sum(int,month)+1
    end

(* val month_range = fn : int * int -> int list *)
fun month_range(day1:int ,day2: int)=
    if day1>day2
    then []
    else
        what_month(day1)::month_range(day1+1,day2)

(* val oldest = fn : (int * int * int) list -> (int * int * int) option *)
fun oldest(ds: (int * int * int) list)=
    if null ds
    then NONE
    else let fun compair(sds: (int * int * int) list)=
            if null (tl sds)
            then hd sds
            else let val ans = compair(tl sds)
                in
                    if is_older(hd sds,ans)
                    then hd sds
                    else ans
                end
        in
            SOME (compair(ds))
        end

fun remove_duplicate(month: int list,result: int list)=
        if null month
        then result
        else let fun check_duplicate(xs:int list)=
                if null xs
                then remove_duplicate(tl month, result@[hd month])
                else if hd month = hd xs
                    then remove_duplicate(tl month, result)
                    else check_duplicate(tl xs)
        in
            check_duplicate(result)
        end

fun number_in_months_challenge(ds: (int*int*int) list,ms: int list)=
    number_in_months(ds,remove_duplicate(ms,[]))

fun dates_in_months_challenge(ds:(int * int * int) list, ms: int list)=
    dates_in_months(ds,remove_duplicate(ms,[]))

fun reasonable_date(date: int*int*int)=
    if #1 date >0 andalso #2 date >0 andalso #2 date<13 andalso #3 date>0
    then
        let val non_leap = [31,28,31,30,31,30,31,31,30,31,30,31]
            val leap = [31,29,31,30,31,30,31,31,30,31,30,31]
            fun get_nth_int(ls:int list,n:int)=
                if null ls 
                then 0
                else if n = 1
                    then hd ls
                    else get_nth_int(tl ls, n-1)
        in
        if (#1 date mod 400 = 0 orelse (#1 date mod 4 = 0 andalso #1 date mod 100 <> 0))
        then 
            if #3 date <= get_nth_int(leap,#2 date)
            then true
            else false
        else
            if #3 date <= get_nth_int(non_leap,#2 date)
            then true
            else false
        end
    else false
