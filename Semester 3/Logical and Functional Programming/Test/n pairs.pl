% n count
%count_nr(L1...Ln,elem) = 0 if empty list
%					1+count_nr(l2...ln) if l1=elem
count_nr([],_,0).
count_nr([H|T],EL,N):-
    H=:=EL,
    count_nr(T,EL,N1),
    N is N1+1.
count_nr([H|T],EL,N):-
    H=\=EL,
    count_nr(T,EL,N).

removeEl([],_,[]).
removeEl([H|T],El,R):-
    H=:=El,
    removeEl(T,El,R).
removeEl([H|T],El,[H|R]):-
    H=\=El,
    removeEl(T,El,R).
    

mainList([],[]).
mainList([H|T],[[H,N]|Res]):-
	count_nr([H|T],H,N),
    removeEl([H|T],H,RL),
    mainList(RL,Res).