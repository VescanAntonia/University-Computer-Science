%P1 1
%a) lowest common multiple

% we find the greator divisor
%gcd(a,b) = b if a =0
%			a if b=0
%			gcd(a mod b,b) if a>=b
%			gcd(a,b mod a) if b>a
% A - integer, B-integer
% (i,i,o) f flow model
 
gcd(0,B,B):-!.
gcd(A,0,A):-!.
%gcd(A,A,A).
gcd(A,B,R):-
    A>=B,
    A1 is mod(A,B),
    gcd(A1,B,R).
gcd(A,B,R):-
    A<B,
    B1 is mod(B,A),
    gcd(A,B1,R).

% lcm(a,b) = 0 if a =0 or b=0
% 			a*b/gcd(a,b) otherwise
% a nr,b nr
% (i,i,o) - flow model
lcm(0,_,0).
lcm(_,0,0).
lcm(A,B,R):-
    gcd(A,B,R1),
    R is A*B/R1.

% mainLcm(l1,l2,...ln) = l1 if the list has only one element
% 						 lcm(l1,mainLcm(l2...ln))
%L - list
%(i,o) - flow model

mainLcm([E],E).
mainLcm([H|T],Res):-
    mainLcm(T,R),
    lcm(H,R,Res).


pow2(X, R) :- 
    X > 0 , 
    R is X /\ (X-1).
% addElem(l1,...ln,elem,pos) = [] if the list is empty
%							   l1 U addElem(l2...ln) if not pos of pow 2
%							   l1 U elem U addElem(l2,..ln) if pos of pow 2
addElem([],_,_,[]).
addElem([H|T],E,Pos,[H,E|Res]):-
    pow2(Pos,R),
    R=:=0,
    Pos1 is Pos+1,
    addElem(T,E,Pos1,Res).
addElem([H|T],E,Pos,[H|Res]):-
    Pos1 is Pos+1,
    addElem(T,E,Pos1,Res).
    
    