%P1 - PB3
% remove repetitive elements
% ex [1,2,1,4,1,3,4] => [2,3]

%findOcc(l1,l2...ln,elem,N) = 0 if the list is empty
%							  findOcc(l2..ln,elem,N+1) if l1=elem
%							  findOcc(l2...ln,elem,N) if l1!=elem
% L - list, elem - integer, N integer
% (i,i,i) - flow model
findOcc(_,[],0).
findOcc(E,[H|T],N):-
    E=:=H,
    findOcc(E,T,N1),
    N is N1+1.
findOcc(E,[H|T],N):-
    E=\=H,
    findOcc(E,T,N).

removeEl([],_,[]).
removeEl([H|T],E,R):-
    H=:=E,
    removeEl(T,E,R).
removeEl([H|T],E,[H|R]):-
    H=\=E,
    removeEl(T,E,R).
%removeElems(l1,...ln) = [] if the list is empty
%						 l1 U removeElems(l2..ln) if findOcc(l1)=1
%						 removeElems(l2...ln) if l1 appears more than once

removeElems([],[]).
removeElems([H|T],[H|Res]):-
    findOcc(H,[H|T],N),
    N=:=1,
    removeEl([H|T],H,RL),
    removeElems(RL,Res).
removeElems([H|T],Res):-
    findOcc(H,[H|T],N),
    N=\=1,
    removeEl([H|T],H,RL),
    removeElems(RL,Res).

%b) remove all occ of a maximum value from a list

maxi(A,B,A):-
    A>=B.
maxi(A,B,B):-
    A<B.

%findMaxArr(l1,l2,...ln,maxim) = l1 if it has only one element	
%								 findMaxArr(l2..ln,l1) if l1>maxim
%								 findMaxArr(l2...ln,maxim) if maxim>l1



findMaxArr([H],H).
findMaxArr([H|T],M):-
    findMaxArr(T,R),
    maxi(H,R,M).

mainRemMax([],[]).
mainRemMax([H|T],R):-
    findMaxArr([H|T],Maxi),
    removeEl([H|T],Maxi,R).



