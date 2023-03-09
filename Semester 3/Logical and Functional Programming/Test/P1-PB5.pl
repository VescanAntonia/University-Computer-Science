%p1-pb5
% a) compute union of two sets

%removeAllOcc(l1,l2...ln,elem) = [] if the list is empty 
%								removeAllOcc(l2,...ln) if l1=elem
%								l1 U removeAllOcc(l2...ln) if l1!=elem
removeElAllOccurencies([],_,[]).
removeElAllOccurencies([H|T],El,[H|Res]):-
    H=\=El,
    removeElAllOccurencies(T,El,Res).
removeElAllOccurencies([H|T],El,Res):-
    H=:=El,
    removeElAllOccurencies(T,El,Res).

findOcc([],_,0).
findOcc([H|T],El,N):-
    H=:=El,
    findOcc(T,El,N1),
    N is N1+1.
findOcc([H|T],El,N):-
    H=\=El,
    findOcc(T,El,N).
    

%findUnion(l1,l2...ln, m1 m2...mn) = [] if both lists are empty
%									 L if M is empty
%									 M if L is empty
%									 l1 U findUnion(l2...ln, removeAllOcc(m1,m2...mn)) if l1 not in M
%									m1 U findUnion(removeAllOcc(l1,...ln),m2...mn) if m1 not in L
%(i,i,o)

findUnion([],[],[]).
findUnion([H|T],B,[H|Res]):-
    %removeElAllOccurencies([H|T],H,R1),
    removeElAllOccurencies(B,H,R2),
    findUnion(T,R2,Res).
findUnion([],B,Res):-
    findUnion(B,[],Res).
