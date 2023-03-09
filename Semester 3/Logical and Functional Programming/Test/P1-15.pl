% P1-PB15
% a) transform a list in a set considering first occurence

remove_occ([],_,[]).
remove_occ([H|T],El,R):-
    H=:=El,
    remove_occ(T,El,R).
remove_occ([H|T],El,[H|R]):-
    H=\=El,
    remove_occ(T,El,R).

mainSet([],[]).
mainSet([H|T],[H|R]):-
    remove_occ([H|T],H,RL),
    mainSet(RL,R).

% b) decompose first even than odd
decompose_even([],[]).
decompose_even([H|T],[H|Res]):-
    R is mod(H,2),
    R=:=0,
    decompose_even(T,Res),!.
decompose_even([H|T],Res):-
    R is mod(H,2),
    R=:=1,
    decompose_even(T,Res).
    
decompose_odd([],[]).
decompose_odd([H|T],[H|Res]):-
    R is mod(H,2),
    R=:=1,
    decompose_odd(T,Res),!.
decompose_odd([H|T],Res):-
    R is mod(H,2),
    R=:=0,
    decompose_odd(T,Res).
    
main_decompose([H|T],Res):-
    decompose_odd([H|T],R1),
    decompose_odd([H|T],R2),
    inserare(R1,Res,R),
    inserare(R2,R,Res2),
    Res is Res2.
    
inserare([],L,L).
inserare([H|T],L,[H|R]):-
    inserare(T,L,R).
    


decompose([], [0, 0, [], []]).
decompose([H|T], [H1f, H2, [H|H3], H4]) :- H mod 2 =:= 0,
    decompose(T, [H1, H2, H3, H4]),
	H1f is H1 + 1.
decompose([H|T], [H1, H2f, H3, [H|H4]]) :- H mod 2 =:= 1,
    decompose(T, [H1, H2, H3, H4]),
	H2f is H2 + 1.

    