%Insert an element on the position n in a list.
%The first parameter is the element, second is the position on which we want to add, 
%the third the list of numbers and the last one is the new list
%insert_el(integer,integer,list,list)
% (i,i,i,o) - flow model

%insert_at_pos(7,1,[1,2,3],L)



VAR 2:
insert_at_pos(_El,_Pos,[],[]).
insert_at_pos(El,1,L,[El|L]).
insert_at_pos(El,Pos,[H|T],[H|RT]):-
    Pos1 is Pos-1,
    insert_at_pos(El,Pos1,T,RT).

%insert_at_pos(7,1,[1,2,3],L)