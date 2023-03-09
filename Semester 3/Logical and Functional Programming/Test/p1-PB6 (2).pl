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

% mainSet(l1...ln) = true is list a set
%					false if not
% 					mainSet(l2..ln) otherwise
mainSet([]).
mainSet([H|T]):-
    isSet([H|T],R),
    R=:=0,
    mainSet(T),!.
mainSet([H|T]):-
    isSet([H|T],R),
    R=\=0,
    mainSet(T).


% b) a predicate to remove the first three occurencies of a element in the list

%removeEl(l1...ln, El) = [] if the list is empty
%						 l1 U removeEl(l2...ln) if l1 != El
%						 removeEl(l2...ln) if l1=El
%(i,i,o)
%removeEl(L - list, El - integer,Res - list)

removeEl([],_,[]).
removeEl([H|T],El,Res):-
    H=:=El,
    removeEl(T,El,Res).
removeEl([H|T],El,[H|Res]):-
    H=\=El,
    removeEl(T,El,Res).

% remove3(l1..ln,elem,flag) = [] if the list is empty
% 							  L if F=3
%							  remove3(removeEl(l1,..ln,elem),elem,flag+1) if flag<3 and H=El
%							  l1 U remove3(l2..ln,elem,flag) otherwise
% (i,i,i,o)
% (L-list, elem-integer, flag - integer, R -list)

remove3([],_,_,[]):-!.
remove3(L,_,3,L):-!.
remove3([H|T],El,F,Res):-
    H=:=El,
    F1 is F+1,
    %removeEl([H|T],H,R),
    remove3(T,El,F1,Res).
remove3([H|T],El,F,[H|Res]):-
    %H=\=El,
    remove3(T,El,F,Res).
%remove3([H|T],)
    
















    
    