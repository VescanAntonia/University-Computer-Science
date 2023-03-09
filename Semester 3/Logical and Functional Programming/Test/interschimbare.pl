even_list([]).
even_list([_,_|T]):-
    even_list(T).

%get_element(l1,..ln,i,c) = l1 if c=i
%							get_element(l2..ln,i,c+1) otherwise
%							
get_element([H|_],I,C,H):-I=:=C,!.
get_element([_|T],I,C,El):-
    I>C,
    C1 is C+1,
    get_element(T,I,C1,El),!.


%interschimbare(l1...ln,L,pos1,pos2,current) = [] if list empty
%									  		   l1 U interscimbare(l2...ln,L,pos1,pos2,current+1) if pos1!=current and pos2!=curren
%											   get_element(L,pos1) U interschimbare(l2..ln,L,pos1,pos2,current+1) if current=pos1
%											   get_element(L,pos2) U inteschimbare(l2...ln,L,pos1,pos2,current+1) if pos2=current
interschimbare([],_,_,_,_,[]):-!.
interschimbare(L,_,_,Pos2,C,L):-C>Pos2,!.
interschimbare([H|T],L,Pos1,Pos2,C,[H|R]):-
    Pos1=\=C,
    Pos2=\=C,
    C1 is C+1,
    interschimbare(T,L,Pos1,Pos2,C1,R).
interschimbare([_|T],L,Pos1,Pos2,C,[EL2|R]):-
    C=:=Pos1,
    get_element(L,Pos2,1,EL2),
    C1 is C+1,
    interschimbare(T,L,Pos1,Pos2,C1,R).
interschimbare([_|T],L,Pos1,Pos2,C,[EL1|R]):-
    C=:=Pos2,
    get_element(L,Pos1,1,EL1),
    C1 is C+1,
    interschimbare(T,L,Pos1,Pos2,C1,R).
