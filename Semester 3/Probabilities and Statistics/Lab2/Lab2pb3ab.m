% Application 
% A coin is tossed 3 times. Let X denote the number of heads that appear.
%a) Find the probability distribution(pdf) function of X. What type of distribution does
%X have?
n=3;
p=0.5;
k=0:1:n;
y=binopdf(k,n,p);
plot(k,y)
hold on

% b) Find the cumulative distribution(cdf) function of X, FX.
w=0:0.001:n;
z=binocdf(w,n,p);
plot(w,z)
hold off

%point c
% c) Find P (X = 0) and P (X != 1)
p1=binopdf(0,n,p);
p2=1-binopdf(1,n,p);
fprintf('P(X=0)=%1.6f\n', p1)
fprintf('P(X<>1)=%1.6f\n', p2)

%point d
% d) Find P (X ≤ 2), P (X < 2)
p3=binocdf(2,n,p);
p4=binocdf(1,n,p);
fprintf('P(X<=2)=%1.6f\n', p3)
fprintf('P(X<2)=%1.6f\n', p4)

%point e
% e) Find P (X ≥ 1), P (X > 1).
p5=1-binocdf(0,n,p);
p6=1-binocdf(1,n,p);
fprintf('P(X>=1)=%1.6f\n', p5)
fprintf('P(X>1)=%1.6f\n', p6)

%point f) Write a Matlab code that simulates 3 coin tosses and computes the value of the
% variable X.

N = 3;
X = 0;
for i = 1 : N
   toss = rand;
   if toss > 0.5    %0.5 as the probability of succes
     X = X + 1;
   end
end
fprintf('X=%1.6f\n',X)