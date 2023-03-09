%   Plot the graphs of the pdf and cdf of a random variable X having a binomial
%distribution of parameters n and p (given by the user). 
clf
n=input('Nr. of trials n = '); %20
p=input('Probability of success p = ');  %0.5

x=0:1:n;
px=binopdf(x,n,p);
plot(x,px,'r+')
hold on
xx=0:0.01:n;
fx=binocdf(xx,n,p);
plot(xx,fx,'m')
legend('pdf','cdf');