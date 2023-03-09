% Pascal
% = the sum of n independent Geo(p) variables
clear All
n=input('rank of success = ');
p=input('probability of success = ');

for i=1:n
    Y(i)=0;
    while(rand>=p)
        Y(i)=Y(i)+1;
    end
end
X=sum(Y);
clear X;

N=input('number of simulations = ');
for i=1:N
    for j = 1:n
        Y(j)=0;
        while(rand>=p)
            Y(j)=Y(j)+1;
        end
    end
    X(i)=sum(Y);
end
U_X = unique(X); %only distinct values
n_X = hist(X,length(U_X)); %freq
relative_freq = n_X/N; % rel freq
[U_X;relative_freq]
%True Bino(n,p) distr
k = 0:20; %values
pk = nbinpdf(k,n,p);
clf
plot(k,pk,'*',U_X,relative_freq,'o','Markersize',10)
legend('Nbin distr','Simulation')
