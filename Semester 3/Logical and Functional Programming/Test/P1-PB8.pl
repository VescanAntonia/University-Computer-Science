%P1 PB8
% a) det if a list has even nr of elements withour counting them
even_list([]).
even_list([_, _|T]) :- 
    even_list(T).


% predicate to delete first occurence of the minimum nr from a list

% mini(a,b) = a if a<=b
%			  b if b<a

mini(A,B,A):-
    B>=A.
mini(A,B,B):-
    B<A.

% findMini(l1..ln, mini) = 0 if list empty
% 							l1 if it has only one elem
%							findmini(l2...ln,mini) if mini<=l1
%							findmini(l2...ln,l1) if l1<mini

findMini([H],H).
findMini([H|T],R):-
    findMini(T,M),
    mini(H,M,R).

% removeFirst(l1...ln,flag) = list if the flag is 1
%							  l1 U removeFirst(l2...ln,flag) if l1!=min
%							 removeFirst(l2..ln,flag+1) if l1==min 
removeFirst(L,_,1,L).
removeFirst([H|T],Mini,F,[H|Res]):-
	H=\=Mini,
    removeFirst(T,Mini,F,Res).
removeFirst([H|T],Mini,F,Res):-
    H=:=Mini,
    F1 is F+1,
    removeFirst(T,Mini,F1,Res),!.

% given a list L we find the min and remove its first appearence 
mainRem(L,Res):-
    findMini(L,RM),
    removeFirst(L,RM,0,Res).




