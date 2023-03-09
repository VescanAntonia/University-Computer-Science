%exercise 2 Normal
% Approximations of the Binomial distribution
%• Normal approximation of the binomial distribution: For moderate values of
%p (0:05 ≤ p ≤ 0:95) and large values of n (n ! 1),
% Bino(n; p) ≈ Norm (µ = np; σ = squareroot of np(1 − p)) :
%Write a Matlab code to visualize how the binomial distribution gradually takes
%the shape of the normal distribution as n ! 1:
p = input('p= ');
% we check if the prob was correctly inserted
if p < 0.05
    fprintf('p should be greater than 0.05');
end
if p>0.95
    fprintf('p should be less than 0.95');
end
for i = 1 : 10
    n = i*5;
    v=0:n;
    plot(v,binopdf(v,n,p))
    pause(0.5);
end