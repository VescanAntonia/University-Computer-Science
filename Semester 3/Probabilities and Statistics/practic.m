clear
clc
close all
%Nickel powders
x=[3.26, 1.89, 2.42, 2.03, 3.07, 2.95, 1.39, 3.06, 2.46, 3.35, 1.56, 1.79, 1.76, 3.82, 2.42, 2.96];
n=length(x);
m=mean(x);
s=std(x);
%a)5% significance level, do the nickel particles seem to be smaller than
%3?
m0=3;
fprintf('a)\n');
fprintf('We are doing a left-tailed test for the mean, standard deviation is unknown.\n');
type=-1;
alpha1=0.05; %the significance level 
fprintf('Significance level: %f:\n',alpha1)
[h, p, ci, valstat] = ttest(x, m0, alpha1, type);
t1=(m-m0)/s*sqrt(n);
l=-Inf;
r=icdf('t',alpha1,n);
fprintf('The rejection region, RR, is (%f, %f)\n',l,r)
fprintf('The value of the test statistic t is %f (given by ttest %f).\n', t1, valstat.tstat);
fprintf('The P-value of the test is %.10f.\n',p)
if h==1
    fprintf('The null hypothesis is rejected (t in RR),so the nickel particles seem to be smaller than 3.\n')
else
    fprintf('The null hypothesis is not rejected (t not in RR), so the nickel particles seem to not be smaller than 3.\n')
end

%b)Find 99% confidence interval for the standard deviation
fprintf('b)\n');
alpha2=0.01;
n=length(x);
q1=icdf('chi2',1-alpha2/2,n-1);
q2=icdf('chi2',alpha2/2,n-1);
v=var(x);
li=(n-1)*v/q1;
ri=(n-1)*v/q2;
fprintf('Confidence interval for the standard deviation:\n')
fprintf('(%.4f, %.4f)\n', sqrt(li), sqrt(ri))