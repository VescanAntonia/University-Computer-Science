%P1-PB7
% a) intersection of two sets
% isIn(l1...ln,elem,N) = 0 if the list empty
% 						isIn(l2...ln,elem,N+1) if the element is n the list
%						isIn(l2...ln,elem,N+1) if the element not in the list
% (i,i,i)

isIn([],_,0).
isIn([H|T],El,N):-
    H=:=El,
    isIn(T,El,N1),
    N is N1+1.
isIn([H|T],El,N):-
    H=\=El,
    isIn(T,El,N).

% doIntersection(l1...ln, r1...rn) = [] if both lists empty or only one of them
%									 l1 U doIntersection()
doIntersection([],[],[]).
doIntersection([],_,[]).
doIntersection(_,[],[]).
doIntersection([H|T],L,[H|Res]):-
    isIn(L,H,N),
    N=\=0,
    doIntersection(T,L,Res).
doIntersection([H|T],L,Res):-
    isIn(L,H,N),
    N=:=0,
    doIntersection(T,L,Res).


% b)create a list (m...n) of all integer numbers from the interval [m,n]
% createList(m,n) = [m] if m==n
% 					m U createList(m+1,n) if m <= n
% 					createList(m,n) if m>n
createList(M,N,[M]):-
	M=:=N.
createList(M,N,[M|Res]):-
    M<N,
    M1 is M+1,
    createList(M1,N,Res),!.
%createList(M,N,Res):

