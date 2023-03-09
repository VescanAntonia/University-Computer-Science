% P3
% Problem 4. The list a1...an is given. Write a predicate to determine all subslists strictly 
% ascending of this list a.
% example: mainSubs([1,2,3,4],R) => [1, 2, 3, 4], [1, 2, 3], [1, 2, 4], [1, 2], [1, 3, 4], [1, 3], 
% 									[1, 4], [1], [2, 3, 4], [2, 3], [2, 4], [2], [3, 4], [3], [4], []]
% 									
% ascending(l1,l2,...,ln) = True if the list is empty or has only one element
%						    False if l1>l2
%						    ascending(l2...ln) if l1<=l2
% ascending(L - list)
% (i) - flow model

ascending([]):-!.
ascending([_]):-!.
ascending([H1,H2|T]):-
    H1=<H2,
    ascending([H2|T]).

% subs(l1,l2...ln) = [] if the list is empty
%					 l1 U subs(l2...ln) if the list is not empty
%					 subs(l2...ln)
% subs(L - list, R - list)
% (i,o) - flow model

subs([],[]).
subs([H|T],[H|R]):-
    subs(T,R).
subs([_|T],R):-
    subs(T,R).

% detSublists(l1,l2...ln) = [] if the list is empty
%							subs(l1,l2...ln),ascending(subs(l1,l2,...ln))
% detSublists(L - list, R - list)
%(i,o) - flow model

detSublists([],[]).
detSublists(L,R):-
    subs(L,R),
    ascending(R).

% mainSubs(L - list,R - list)
% The first parameter is the initial list and the second parameter is the list containing all the ascending sublists of the given list.
% (i,o) - flow model

mainSubs(L,R):-
    findall(X,detSublists(L,X),R).
