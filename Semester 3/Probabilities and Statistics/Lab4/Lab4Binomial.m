%Binomial
clear ALL;
p=input('probability of succes(0,1) = ');
n=input('number of trials = ');
U=rand(n,1);
N=input('Number of simulations = ');
for i=1:N
    U=rand(n,1);        %a bino is the sum of n independent Bern(p)
    X(i)=sum(U<p);
end
U_X=unique(X);
n_X=hist(X,length(U_X))
relative_freq=n_X/N

[U_X;relative_freq]

xpdf=0:n;
ypdf=binopdf(xpdf,n,p);
clf;
plot(xpdf,ypdf,'bo', U_X,relative_freq,'rx','MarkerSize',10);
legend('binopdf','simulations');
