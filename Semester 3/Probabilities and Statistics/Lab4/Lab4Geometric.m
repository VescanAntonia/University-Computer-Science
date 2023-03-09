% Geometric
% =the nr of Bernoulli trials that ended up being failures
clear ALL
p=input('probability of succes(0,1) = ');
X=0;
while(rand>=p)
    X=X+1;
end
N=input('number of simulations = ')
for i=1:N                      
    X(i)=0;
    while(rand>=p)
        X(i)=X(i)+1;
    end
end

U_X = unique(X); %only distinct values
n_X = hist(X,length(U_X)); %freq
relative_freq = n_X/N; % rel freq
[U_X;relative_freq]

k = 0:20;
geo = geopdf(k,p);
clf
plot(k,geo,'*',U_X,relative_freq,'rx')
legend('Geo distr','Simulation')