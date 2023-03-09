% P1 - PB13
% transform a list in a set (last occurencies)

removeEl([],_,[]).
removeEl([H|T],El,Res):-
	H=:=El,
    removeEl(T,El,Res).
removeEl([H|T],El,[H|Res]):-
    H=\=El,
    removeEl(T,El,Res).

isIn([],_,0).
isIn([H|T],El,N):-
    H=:=El,
    isIn(T,El,N1),
    N is N1+1.
isIn([H|T],El,N):-
    H=\=El,
    isIn(T,El,N).
%toSet(l1..ln) = [] if list empty
%				 l1 U toSet(l2...ln) if l1 apears more than once in the list
%				 l1 U removeEl(toSet(l2...ln),l1)

toSet([],[]):-!.
toSet([H|T],[H|Res]):-
    isIn(T,H,N),
    N=:=0,
    toSet(T,Res),!.
toSet([_|T],Res):-
    toSet(T,Res).


% b) greater common divisor 
% gcd = a if b=0
%       b if a =0
%		gcd(a%b,b) if a>=b
%		gcd(a,b%a) if b>a
gcd(A,0,A).
gcd(0,B,B).
gcd(A,B,Res):-
    A>=B,
    A1 is mod(A,B),
	gcd(A1,B,Res).
gcd(A,B,Res):-
    B>A,
    B1 is mod(B,A),
    gcd(A,B1,Res).


gcdList([],0).
gcdList([H|T],Res):-
	gcdList(T,R1),
    gcd(H,R1,Res).


