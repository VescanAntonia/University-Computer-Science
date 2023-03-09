% P1 - PB12
% a) substitute in a list a value with all the elements of another list

inserare([],L,L).
inserare([H|T],L,[H|R]):-
    inserare(T,L,R).

main([],_,_,[]).
main([H|T],L,EL,Res):-
    H=:=EL,
    main(T,L,EL,RL),
    inserare(L,RL,Res).
main([H|T],L,EL,[H|Res]):-
    EL=\=H,
    main(T,L,EL,Res).



% b) remove n th element
% remove_n(l1...ln,n,pos) = [] if the list is empty
% 						  L if pos>n
%						  l1 U remove_n(l2...ln,n,pos+1) if pos!=n
%						  remove_n(l2...ln,n,pos+1) if pos=n
remove_n([],_,_,[]).
remove_n(L,N,Pos,L):-
    Pos>N.
remove_n([H|T],N,Pos,[H|Res]):-
    Pos=\=N,
    Pos1 is Pos+1,
    remove_n(T,N,Pos1,Res),!.
remove_n([_|T],N,Pos,Res):-
    Pos=:=N,
    Pos1 is Pos+1,
    remove_n(T,N,Pos1,Res).
