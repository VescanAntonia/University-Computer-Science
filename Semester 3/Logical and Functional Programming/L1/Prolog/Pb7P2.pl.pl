% Problem 7
% a)Determine the position of the maximal element of a linear list.
% example: maxpos([10,14,12,13,14],L) produces L=[2,5].

% maxi(X,Y) = X if X>=Y
% 		      Y if X<Y
% maxi(X - integer, Y - integer, R - integer)
% (i,i,o) - flow model

maxi(X,Y,X):-
    X>=Y.
maxi(X,Y,Y):-
    X<Y.

% findMax(l1,l2,...,ln) = l1 if the list has only one element
%                         maxi(l1,findMax(l2,l3,...,ln))
% findMax(L - list,R - integer)
% (i,o) - flow model

findMax([H],H).
findMax([H|T],R):-
    findMax(T,R1),
    maxi(H,R1,R).

%findPositions(l1,l2,...,ln, pos, maxEl) = [] if the list is empty
%										   pos U findPositions(l2,...,ln, pos+1, maxEl) if l1=maxEl
%                                          findPositions(l2,...,ln, pos+1, maxEl) if l1!=maxEl
% findPositions(L - list, Pos - integer, MaxEl - integer, R - list)
% (i,i,i,o) - flow model

findPositions([],_,_,[]).
findPositions([H|T],Pos,MaxEl,[Pos|R]):-
    H=:=MaxEl,
    Pos1 is 1+Pos,
    findPositions(T,Pos1,MaxEl,R).
findPositions([H|T],Pos,MaxEl,R):-
    H=\=MaxEl,
    Pos1 is 1+Pos,
    findPositions(T,Pos1,MaxEl,R).

% maxpos(L-list, R-list)
% The first parameter is the intial list and the second parameter is the resulting list with the positions of the maximum 
% element.
% (i,o) - flow model

maxpos(L,R):-
    findMax(L,Res),
    findPositions(L,1,Res,R).

% b)For a heterogeneous list, formed from integer numbers and list of numbers, replace every sublist with the position 
% of the maximum element from that sublist.
% example: [1,[2,3],[4,1,4],3,6,[7,10,1,3,9],5,[1,1,1],7] => [1,[2],[1,3],3,6,[2],5,[1,2,3],7]
% replace_max([1,[2,3],[4,1,4],3,6,[7,10,1,3,9],5,[1,1,1],7],L)

% replace_max(l1,l2,...,ln) = [] if the list is empty
%                             maxpos(l1,findPositions(l1),1) U replace_max(l2,...,ln) if l1 is a list
%                             l1 U replace_max(l2,...,ln) if l1 is not a list
% replace_max(L - list, R - resulting list)
% (i,o) - flow model

replace_max([],[]).
replace_max([H|T],[R1|R]):-
    is_list(H),!,
    maxpos(H,R1),
    replace_max(T,R).
replace_max([H|T],[H|R]):-
    \+is_list(H),
    replace_max(T,R).
