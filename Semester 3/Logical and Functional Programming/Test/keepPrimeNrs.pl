%nr prime
%det_divisors(nr,count,N)=0 if count==nr
%						  det_divisors(nr,count+1,N+1) if nr%count==0
%						  det_divisors(nr,count+1,N) if nr%count==0
det_divisor(1,_,0):-!.
det_divisor(Nr,C,0):-
    Nr=:=C.
det_divisor(Nr,C,N):-
    R is mod(Nr,C),
    Nr>C,
    R=:=0,
    C1 is C+1,
    det_divisor(Nr,C1,N1),
    N is N1+1,!.
det_divisor(Nr,C,N):-
    R is mod(Nr,C),
    R=\=0,
    C1 is C+1,
    det_divisor(Nr,C1,N),!.

%we start from 2 in order to see who has other divisors than 1 and itself
%keep_prim(l1...ln) = [] if the list is empty
%					  l1 U kee_prim(l2...ln) if l1 e prim
%					  keep_prim(l2...ln) if l1 nu e prim
%(i,o) - flow model
% (L list, R list)

keep([],[]).
keep([H|T],[N|R]):-
    det_divisor(H,2,N),
    keep(T,R).

keep_prim([],[]).
keep_prim([H|T],[H|R]):-
    det_divisor(H,2,N),
    N=:=0,
    keep_prim(T,R),!.
keep_prim([_|T],R):-
    keep_prim(T,R),!.



