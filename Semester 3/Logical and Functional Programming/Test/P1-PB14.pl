%P1 - PB14
% set equality
isIn([],_,0).
isIn([H|T],El,N):-
    H=:=El,
    isIn(T,El,N1),
    N is N1+1.
isIn([_|T],El,N):-
    isIn(T,El,N).

list_len([],0).
list_len([_|T],N):-
    list_len(T,N1),
	N is N1+1.

removeEl([],_,[]).
removeEl([H|T],El,Res):-
	H=:=El,
    removeEl(T,El,Res).
removeEl([H|T],El,[H|Res]):-
    H=\=El,
    removeEl(T,El,Res).

mainEq([],[]):-!.
mainEq([H1|T1],[H2|T2]):-
    list_len([H1|T1],N1),
    list_len([H2|T2],N2),
    N1=:=N2,
    isIn([H2|T2],H1,M1),
    isIn([H1|T1],H2,M2),
    M1=\=0,
    M2=\=0,
    removeEl([H2|T2],H2,RL2),
    removeEl([H1|T1],H1,RL1),
    mainEq(RL1,RL2).



% b) select the n th element of a given list
% select_n = l1 if n=1
%			 select_n(l2...ln,n-1) if n>1
             
select_n([H|_],1,H).
select_n([_|T],Pos,Res):-
    Pos1 is Pos-1,
    select_n(T,Pos1,Res).
             
             
             
             