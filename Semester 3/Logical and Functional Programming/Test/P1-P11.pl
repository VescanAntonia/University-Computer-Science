% P1-pb11
% a) substitute one element with another

%substitute_el(l1..ln,el1,el2) = [] if the list is empty
%								el2 U substitute_el(l2...ln) if l1=el1
%								el1 U substitute_el(l2...ln) if l1=el2

subs_el([],_,_,[]).
subs_el([H|T],EL1,EL2,[EL2|Res]):-
	H=:=EL1,
    subs_el(T,EL1,EL2,Res).
subs_el([H|T],EL1,EL2,[EL1|Res]):-
    H=:=EL2,
    subs_el(T,EL1,EL2,Res).
subs_el([H|T],EL1,EL2,[H|Res]):-
    subs_el(T,EL1,EL2,Res).

% b) get sublist lm.....ln from list l1....lk
% get_subs(l1...lk,m,n,pos) = [] if pos>n
%						      l1 U get_subs(l2...lk,m,n,pos+1) if pos<=n and pos>=m
%							  get_subs(l2...lk,m,n,pos+1) if pos<m

get_subs(_,_,N,Pos,[]):-
    Pos>N.
get_subs([H|T],M,N,Pos,[H|Res]):-
    N>=Pos,
    Pos>=M,
    Pos1 is Pos+1,
    get_subs(T,M,N,Pos1,Res).
get_subs([_|T],M,N,Pos,Res):-
    Pos1 is Pos+1,
    get_subs(T,M,N,Pos1,Res).
    
