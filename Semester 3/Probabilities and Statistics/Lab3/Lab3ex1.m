%exercise 1

%mu=input('mu= ');
%sigma=input('sigma(>0)= ');
clear
alpha=input('alpha(in(0,1)= ');
beta=input('beta in(0,1)= ');
option_distribution = input('option(normal/student/n/fischer): ', 's');

switch option_distribution
    case 'normal'
        fprintf('normal case\n');
        mu = input('mu= ');
        sigma = input('sigma= ');
        %a) P(X ≤ 0) and P(X ≥ 0);
        pa = normcdf(0, mu, sigma);
        fprintf('Probability for a) %f\n', pa)
        pb = 1-pa;
        fprintf('Probability for a) %f\n', pb)
        %b) P(−1 ≤ X ≤ 1) and P(X ≤ −1 or X ≥ 1)
        pc = normcdf(1, mu, sigma) - normcdf(-1, mu, sigma);
        fprintf('Probability for b) %f\n', pc);
        pd = 1 - pc;
        fprintf('Probability for b) %f\n', pd);
        %c) the value xα such that P(X < xα) = α, for α in (0; 1) (xα is called the quantile of order α);
        pe = norminv(alpha, mu, sigma);
        fprintf('Probability for c) %f\n', pe);
        %d) the value xβ such that P(X > xβ) = β, for β in (0; 1) (xβ is the quantile of
        % order 1 − β).
        pf = norminv(1 - beta, mu, sigma);
        fprintf('Probability for d) %f\n', pf);
    case 'student'
        fprintf('student case\n');
    case 'fischer'
        fprintf('fischer case\n');
    otherwise
        fprintf('Wrong input\n');
        exit
end