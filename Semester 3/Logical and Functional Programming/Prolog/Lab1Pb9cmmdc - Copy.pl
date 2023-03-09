%Define a predicate to determine the greatest common divisor of all numbers in a list
%cmmdc(i,i,o) - flow model
%X first nr, Y the second one, Res the result
cmmdc(X,0,Res):-
    Res is X.

cmmdc(X,Y,Res):-
    R is mod(X,Y),
    cmmdc(Y,R,Res).
%cmmdcList(i,o) - flow model
%the list, and the result
cmmdcList([],_R).

cmmdcList([H|T],R):-
    cmmdcList(T,R1),
    cmmdc(H,R1,R).

%cmmdcList([2,4,8],X)