% P1-PB10
% a) det if it has a valley aspect
% valleyAsp(l1...ln,f) = true if the list has only one element and f=1
%						 valleyAsp(l2,...ln,1) l1<l2
%						 valleyAsp()l2...ln,0) l1>l2
%						 false otherwise

valleyAsp([_],1:-!).
valleyAsp([H1,H2|T],_):-
    H1<H2,
    valleyAsp([H2|T],1),!.
valleyAsp([H1,H2|T],0):-
    H1>H2,
    valleyAsp([H2|T],0),!.

% b) suma alternativa a unei liste
% sumaAlternativa(l1..ln,pos) = 0 if list empty
% 								l1-sumaAlternativa(l2...ln) if pos%2==1
%								l1+sumaAlternativa(l2,...ln) if pos%2==0

%sumaAlternativa([],_,Res):-Res is 0.
%sumaAlternativa([H|T],Pos,Res):-
 %   R is mod(Pos,2),
  %  Pos1 is Pos+1,
   % R=:=1,
    %sumaAlternativa(T,Pos1,H1),
    %Res is H-H1.
%sumaAlternativa([H|T],Pos,Res):-
 %   R is mod(Pos,2),
  %  Pos1 is Pos+1,
   % R=:=0,
    %sumaAlternativa(T,Pos1,H1),
    %Res is H+H1.


altSum([],0).
altSum([H],H).
altSum([H1,H2|T],Res):-
    altSum(T,R),
    Res is H1-H2+R.
    
    
    
    


