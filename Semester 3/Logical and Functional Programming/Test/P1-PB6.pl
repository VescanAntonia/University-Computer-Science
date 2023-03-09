% P1 - PB6 
% a) test if a list is a set
%getOcc(l1,l2...ln,elem) = 1+getOcc(l2...ln,elem)
%						   getOcc(l2,..ln,elem)
getOcc([],_,0).
getOcc([H|T],El,N):-
    H=:=El,
    getOcc(T,El,N1),
    N is N1+1.
getOcc([H|T],El,N):-
    H=\=El,
    getOcc(T,El,N).

%isSet(l1...ln,flag) = 0 if the list is empty 
%					   isSet(l2...ln,F+1) if l1 appears more than once in the list
%					   isSet(l2...ln,F) if l1 only once

isSet([],0).
isSet([H|T],F):-
    getOcc([H|T],H,N),
    N=\=0,
    isSet(T,F1),
    F is F1+1.
isSet([H|T],F):-
    getOcc([H|T],H,N),
    N=:=0,
    isSet(T,F).

mainSet([]).
mainSet([H|T]):-
    isSet([H|T],R),
    R=:=0,
    mainSet(T),!.
mainSet([H|T]):-
    isSet([H|T],R),
    R=\=0,
    mainSet(T).
    
    


    