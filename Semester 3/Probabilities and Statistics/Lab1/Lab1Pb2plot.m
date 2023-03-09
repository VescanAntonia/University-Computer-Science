x=0:0.01:3;
y=x.^5/10;
a=x.*sin(x);
b=cos(x);
plot(x,y,x,a,':b',x,b,'-.m')
title('My plot')
legend('f1=x^5/10','f2=x*sin(x)','f3=cos(x)')