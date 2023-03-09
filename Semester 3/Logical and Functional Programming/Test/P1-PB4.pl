%P1 - PB4
%a) det the difference of two sets

%isInList(l1,l2,...ln,elem) = 1 if elem is in the given list
%								0 otherwise

isInList([],_,0).
isInList([H|T],E,N):-
    H=:=E,
    isInList(T,E,N1),
    N is N1+1.
isInList([H|T],E,N):-
    H=\=E,
    isInList(T,E,N).

setsDifference([],_,[]).
setsDifference(_,[],_).
setsDifference([H1|T1],[H2|T2],[H1|Res]):-
    isInList([H1|T1],H2,R),
    R=:=0,
    setsDifference(T1,[H2|T2],Res).
setsDifference([H1|T1],[H2|T2],Res):-
    isInList([H1|T1],H2,R),
    R=\=0,
    setsDifference(T1,[H2|T2],Res).

% b) add value 1 after every even element 
% addValueOne(l1,l2,...ln) = [] if the list is empty
% 							 l1 U 1 U addValueOne(l2...ln) if l1 is even
%							 l1 U addValueOne(l2...ln) if l1 is not even

addValueOne([],[]).
addValueOne([H|T],[H,1|Res]):-
    R is mod(H,2),
    R=:=0,
    addValueOne(T,Res).
addValueOne([H|T],[H|Res]):-
    R is mod(H,2),
    R=\=0,
    addValueOne(T,Res).
    
    

