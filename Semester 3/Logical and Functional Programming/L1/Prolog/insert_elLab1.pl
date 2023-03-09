%Insert an element on the position n in a list.
%The first parameter is the list, second the element we want to add, the third the position
% and the last one is the new list
%insert_el(list,integer,integer,list) 
%(i,i,i,o) - flow model
insert_el([],_,_,[]).
insert_el(L,E,1,[E|L]):-
    !.
insert_el([H|T],E,N,[H|Rez]):-
    N>1,
    !,
    N1 is N-1,
    insert_el(T,E,N1,Rez).

%insert_el([1,2,3],7,1,L)
