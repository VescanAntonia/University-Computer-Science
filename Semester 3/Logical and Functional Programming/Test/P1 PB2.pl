%P1 - PB2
% a) remove given atom from a list

%removeFromList(l1,l2,..ln,elem)=[] if the list is empty
%								removeFromList(l2,...ln) if l1=elem
%								l1 U removeFromList(l2...ln) if l1!=elem
removeFromList([],_,[]).
removeFromList([H|T],Elem,Res):-
    H=:=Elem,
    removeFromList(T,Elem,Res).
removeFromList([H|T],Elem,[H|Res]):-
    H=\=Elem,
    removeFromList(T,Elem,Res).

% Define a pred to produce a list of pairs atom n from an initial list of atoms
% a pair to replace every element with a list formed by it and the nr of times it appears

% findOcc(Elem,l1,l2...ln,N) = 0 if the list is empty
% 								findOcc(Elem,l2,..ln,N+1) if l1=Elem
%								findOcc(Elem,l2...ln,N) if l1!=Elem

findOcc(_,[],0).
findOcc(Elem,[H|T],N):-
    H=:=Elem,
    findOcc(Elem,T,N1),
    N is N1+1.
findOcc(Elem,[H|T],N):-
    H=\=Elem,
    findOcc(Elem,T,N).

%ToList(l1,l2,...,ln) = [] if list is empty
%						[l1,findOcc(l1,l2..ln,l1)] U toList(removeFromList(l1,l2...ln))
toList([],[]).
toList([H|T],[[H,R]|Res]):-
    findOcc(H,[H|T],R),
    removeFromList(T,H,RL),
    toList(RL,Res).
