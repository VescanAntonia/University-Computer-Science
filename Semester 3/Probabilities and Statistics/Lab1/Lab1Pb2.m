x=0:0.01:3;
y=x.^5/10;
a=x.*sin(x);
b=cos(x);
plot(x,y,x,a,':b',x,b,'-.m')
title('My plot')
legend('f1=x^5/10','f2=x*sin(x)','f3=cos(x)')



%---varianta 2---
x=0:0.1:3; %generates an array with first el 0 last 3 and the common difference between elements is 0.1 like an arithmetic progresion
subplot(4,1,1)
plot(x,x.*sin(x),'-->m',x,x.^5/100,'b',x,cos(x),'<r')  %for each x y pair assigns a special line style...
xlabel("x -> ")  %labels the x-axis 
ylabel("y -> ")  %labels the y-axis
legend("x*sine", "x^5/10", "cosine")   %sets the legend tables
title("The plot")
subplot(4,1,2)
fplot("[x*sin(x)]", [0, 3], ".->")   % plots the function for the interal
subplot(4,1,3)
fplot("[x^5/100]", [0, 3], '.->')
subplot(4,1,4)
fplot("[cos(x)]", [0, 3], '.->')