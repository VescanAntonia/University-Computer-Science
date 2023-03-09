%P1 PB9
% a) Insert element on pos n
%insertPos(l1...ln,el,pos) = [el]U L if pos=0
%							 l1 U insertPos(l2...ln,elem,pos-1) if pos!=0

insertPos(L,El,1,[El|L]).
insertPos([H|T],El,Pos,[H|Res]):-
    Pos1 is Pos-1,
    insertPos(T,El,Pos1,Res).

% b) gcd for a list
% gcd(a,b) = a if b=0
%			b if a=0
% 			gcd(a%b,b) if a>=b
%			gcd(a,b%a) if b>a
gcd(A,0,A):-!.
gcd(0,B,B):-!.
gcd(A,B,Res):-
    A>=B,
    A1 is mod(A,B),
    gcd(A1,B,Res).
gcd(A,B,Res):-
    A<B,
    B1 is mod(B,A),
    gcd(A,B1,Res).

%gcdList(l1...ln) = 0 if the list is empty
%					gcd(gcdList())
gcdList([],0).
gcdList([H|T],R):-
    gcdList(T,Res),
    gcd(H,Res,R).
    
    
    
    
