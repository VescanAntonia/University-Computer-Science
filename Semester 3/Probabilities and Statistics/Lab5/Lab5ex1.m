clear ALL
% a)Assuming that past experience indicates that σ = 5, find a 100(1−α)% confidence
% interval for the average number of files stored.
X = [7 7 4 5 9 9 4 12 8 1 8 7 3 13 2 1 17 7 12 5 6 2 1 13 14 10 2 4 9 11 3 5 12 6 10 7];
sigma = 5;
conflevel=input("confidence level = ");
alpha=1-conflevel;
mx=mean(X);
n=length(X);
z1=norminv(1-alpha/2,0,1);
z2=norminv(alpha/2,0,1);
confinterv1=mx-sigma/sqrt(n)*z1;
confinterv2=mx-sigma/sqrt(n)*z2;
fprintf("The confidence interval for the mean with sigma known is (%f,%f)",confinterv1,confinterv2);

% b)
conflevel2=input("\n confidence level = ");
alpha2=1-conflevel2;
t1=tinv(1-alpha2/2,n-1);
t2=tinv(alpha2/2,n-1);
s=std(X);
ci3=mx-s/sqrt(n)*t1;
ci4=mx-s/sqrt(n)*t2;
fprintf('The confidence interval for the mean with sigma unknown is (%f,%f)',ci3,ci4);

% c)
conflevel3=input("\n confidence level = ");
alpha3=1-conflevel3;
s2=var(X);
t3=chi2inv(1-alpha3/2,n-1);
t4=chi2inv(alpha3/2,n-1);
ci5=(n-1)*s2/t3;
ci6=(n-1)*s2/t4;
fprintf('The confidence interval for the variance is (%f,%f)',ci5,ci6);
fprintf('\nThe confidence interval for the variance is (%f,%f)',sqrt(ci5),sqrt(ci6));


